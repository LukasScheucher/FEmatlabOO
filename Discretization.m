classdef Discretization < handle

  properties(Access=private)
    nodes_ NodeBase
    elements_ EleQuad4
    numdof_@uint16
    dirichcond_
    neumanncond_
  end

  methods(Access=public)
    function this = Discretization()% {{{ctor
      this.numdof_=uint16(0);
    end% }}}

    function [] = AddNode(this,newnode)% {{{add node
      this.nodes_(end+1)=newnode;
      this.numdof_=this.numdof_+newnode.Dim();
    end% }}}

    function [] = AddElement(this, newelement)% {{{add element
      this.elements_(end+1)=newelement;
    end% }}}

    function result = gNode(this,id)
      result=this.nodes_(id);
    end

    function result = gElement(this,id)
      result=this.elements_(id);
    end

    function result = NumNode(this)
      result=length(this.nodes_);
    end

    function result = NumEle(this)
      result=length(this.elements_);
    end

    function result = NumDof(this)
      result=this.numdof_;
    end

    function result = gDirichCond(this)
      result=this.dirichcond_;
    end

    function result = gNeumannCond(this)
      result=this.neumanncond_;
    end


    function [] = SetBoundaryCondRange(this,condtype,dofdirs,values,rangeX,rangeY,rangeZ)
      %looping throug all nodes
      for iter=1:this.NumNode()
        curnode=this.nodes_(iter);
        if (curnode.X()>=rangeX(1)&&...
            curnode.X()<=rangeX(2)&&...
            curnode.Y()>=rangeY(1)&&...
            curnode.Y()<=rangeY(2)&&...
            curnode.Z()>=rangeZ(1)&&...
            curnode.Z()<=rangeZ(2)     )
          %curnode lies within the specified range
          curdofs=curnode.Dofs();
          curnode.AddDofCond(condtype,curdofs(dofdirs),values);
          this.AddDofCond(condtype,curdofs(dofdirs),values);
        end
      end
    end% }}}end setBoundaryCondRange


    function [] = AddDofCond(this,condtype,dofs,values)
      %disp(['AddDofCond called with ',condtype,' ',num2str(dofs),' ',num2str(values)]);
      if length(dofs)~=length(values)
        error('number of dofs does not equal the number of given values');
      end
      if size(dofs,2)>1
        dofs=dofs';
      end
      if size(values,2)>1
        values=values';
      end

      if strcmp(condtype,'dirich')
        this.dirichcond_=[this.dirichcond_; double(dofs) values];
      elseif strcmp(condtype,'neumann')
        this.neumanncond_=[this.neumanncond_; double(dofs) values];
      else
        error('unknown condition type');
      end

    end% }}}end AddDofCond


    %TODO hack, since this is actually a 2D method
    function [] = ApplyDisp(this,sol)
      for iter=1:this.NumNode()
        curdofs=this.nodes_(iter).Dofs();
        this.nodes_(iter).moveX(sol(curdofs(1)));
        this.nodes_(iter).moveY(sol(curdofs(2)));
      end
    end


    function [] = Visualize(this, f)% {{{simple printing function
      figure(f);
      grid off
      axis off
      axis equal
      for iter=1:length(this.elements_)
        this.elements_(iter).Visualize(f);
      end
    end% }}}

    function [] = VisualizeNodes(this,f)
      figure(f)
      hold on
      grid off
      axis off
      axis equal
      for iter=1:length(this.nodes_)
        plot3(this.nodes_(iter).X(),this.nodes_(iter).Y(),this.nodes_(iter).Z(),'om');
        text(this.nodes_(iter).X(),this.nodes_(iter).Y(),this.nodes_(iter).Z(),num2str(this.nodes_(iter).ID() ));
      end
    end

    function [] = VisualizeBC(this,f)
      %loop over all nodes
      for iter=1:this.NumNode()
        this.nodes_(iter).VisualizeBC(f);
      end
    end

    function [] = printout(this)
      for iter=1:length(this.nodes_)
        this.nodes_(iter).printout();
      end
      for iter=1:length(this.elements_)
        this.elements_(iter).printout();
      end
    end
  end

end
