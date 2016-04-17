classdef RectQuadMeshGenerator < handle

%  (4)-------------------(3)
%   |                     |
%   |      meshed         |
%   |       with          |
%   |      quad4s         |
%   |                     |
%   |                     |
%   |                     |
%   |                     |
%  (1)-------------------(2)





  properties(Access=private)
    corners_
    numele12_
    numele14_
    eletype_
  end

  methods(Access=public)
    function this = RectQuadMeshgenerator()% {{{ctor
    end%}}}
    function [] = setCorners(this,corners)
      this.corners_=corners;
    end
    function [] = setNumEle12(this,num)
      this.numele12_=num;
    end
    function [] = setNumEle14(this,num)
      this.numele14_=num;
    end
    function [] = setEleType(this,eletype)
      this.eletype_=eletype;
    end
    function genMesh(this,disobj)% {{{generate nodes and elements
      if isa(disobj,'Discretization')==0
        error('handle to a valid discretization required');
      end

      v12=this.corners_(2,:)-this.corners_(1,:);
      v14=this.corners_(4,:)-this.corners_(1,:);

      a12=[this.corners_(2,:)-this.corners_(1,:)]/this.numele12_;
      a23=[this.corners_(3,:)-this.corners_(2,:)]/this.numele14_;
      a34=[this.corners_(4,:)-this.corners_(3,:)]/this.numele12_;
      a14=[this.corners_(4,:)-this.corners_(1,:)]/this.numele14_;
      
      numele=this.numele12_*this.numele14_;
      numnode=(this.numele12_+1)*(this.numele14_+1);
      pos1=this.corners_(1,:);

      for iter12=0:this.numele12_
        for iter14=0:this.numele14_
          posnew= pos1+iter12*a12+...
               (iter12*a23+(this.numele12_-iter12)*a14)/this.numele12_ * iter14;
          newnode=NodeBase(disobj.NumNode()+1,...
                           uint16(2),...
                           [disobj.NumDof()+1 disobj.NumDof()+2],...
                           posnew(1),posnew(2),0);
          disobj.AddNode(newnode);
        end
      end

      %generate elements
      for iter1=1:this.numele12_
        for iter2=1:this.numele14_
          curNodeIDs=[...
            iter2+(this.numele14_+1)*(iter1-1)+0
            iter2+(this.numele14_+1)*(iter1-0)+0
            iter2+(this.numele14_+1)*(iter1-0)+1
            iter2+(this.numele14_+1)*(iter1-1)+1];

          newele=EleQuad4(disobj.NumEle()+1,...
                          disobj.gNode(curNodeIDs(1)),...
                          disobj.gNode(curNodeIDs(2)),...
                          disobj.gNode(curNodeIDs(3)),...
                          disobj.gNode(curNodeIDs(4)) );
          newele.setE(100);
          newele.setnu(0.3);
          disobj.AddElement(newele);
            
        end
      end

    
    end% }}}

  end

end
