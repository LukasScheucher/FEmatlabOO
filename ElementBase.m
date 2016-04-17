classdef  ElementBase < handle
  properties(Access=protected)
    nodes_ NodeBase
    id_
    numnode_
    E_
    nu_
  end
  methods
    %the following function is required in order to build arrays of this object
    function this = ElementBase()% {{{base ctor
      %error('base class ctor called');
    end% }}}
    function [] = setE(this,val)
      this.E_=val;
    end
    function [] = setnu(this,val)
      this.nu_=val;
    end

    function result = gDofs(this)
      result = [];
      for iter=1:this.numnode_
        result=[result;this.nodes_(iter).ID()*2-1;this.nodes_(iter).ID()*2];
      end
    end

    function [] = printout(this);% {{{print method
      disp(['element ID: ',num2str(this.id_)])
      disp(['   contains ',num2str(this.numnode_),'nodes:']);
      for iter=1:this.numnode_
        disp(['            ',num2str(this.nodes_(iter).ID())])
      end
    end% }}}

  end
end

