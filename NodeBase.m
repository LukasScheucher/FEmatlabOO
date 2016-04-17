classdef NodeBase < handle
  properties(Access=private)
    id_
    pos_
    scalar1_
    scalar2_
    scalar3_
    vector1_
    vector2_
    substructID_
    dofs_@uint16
    dim_@uint16

    %%TODO store actual condition for better Visualization
    dirichcond_@logical=false;
    neumanncond_@logical=false;
  end

  methods(Access=public)
    function this=NodeBase(id,dim,dofs,x,y,z)% {{{ctor
      this.id_=id;
      this.pos_(1,1)=x;
      this.pos_(2,1)=y;
      this.pos_(3,1)=z;
      this.dim_     =dim;
      if(dim==2 && length(dofs)~=2)
        error('node with dim=2 reqires 2 dofs');
      elseif(dim==3 && length(dofs)~=3)
        error('node with dim=3 requires 3 dofs');
      end
      this.dofs_    =dofs;
    end% }}}

    function result = Pos(this)% {{{ getter for pos vector
      result=this.pos_;
    end% }}}

    function result = X(this)% {{{ getter for X
      result=this.pos_(1);
    end% }}}

    function result =Y(this)% {{{ getter for Y
      result=this.pos_(2);
    end% }}}

    function Z = Z(this)% {{{ getter for Z
      Z=this.pos_(3);
    end% }}}

    function [] = moveX(this,deltaX)
      this.pos_(1)=this.pos_(1)+deltaX;
    end

    function [] = moveY(this,deltaY)
      this.pos_(2)=this.pos_(2)+deltaY;
    end

    function [] = moveZ(this,deltaZ)
      this.pos_(3)=this.pos_(3)+deltaZ;
    end

    function result = Dofs(this)% {{{getter for dofs_
      result=this.dofs_;
    end% }}}

    function result = Dim(this)% {{{getter for Dim
      result=this.dim_;
    end% }}}

    function result = ID(this)% {{{getter for ID
      result=this.id_;
    end% }}}

    function result = DirichCond(this)
      result=this.dirichcond_;
    end

    function result = NeumannCond(this)
      result=this.neumanncond_;
    end


    function [] = AddDofCond(this,condtype,dofs,values)
      if strcmp(condtype,'dirich')
        this.dirichcond_=true;
      elseif strcmp(condtype,'neumann')
        this.neumanncond_=true;
      else
        error('unknown condition type');
      end
    end


    function [] = VisualizeBC(this,f,sizedirich,sizeneumann)
      figure(f);
      if this.dirichcond_==true%if ther is a dirichlet condition, dirichcond_ will de a vector of length dim
        %disp(['===node ',num2str(this.id_),' is now printint diriccond',num2str(this.dirichcond_)]);
        plot3(this.X(),this.Y(),this.Z(),'ms');
      end
      if this.neumanncond_==true
        plot3(this.X(),this.Y(),this.Z(),'gd','MarkerSize',12);
      end

    end



    function [] = printout(this)% {{{simple print function
      disp(['Node ',num2str(this.id_),' X:',num2str(this.pos_(1) ),...
              ' Y:',num2str(this.pos_(2) ),' Z:',num2str(this.pos_(3) ) ]);
    end% }}}
  end
end

