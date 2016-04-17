classdef EleQuad4 < ElementBase

  properties(Access = private)
  end

  methods(Access=public)
    function this=EleQuad4(ID,node1,node2,node3,node4)% {{{ctor
      this.id_=ID;
      this.nodes_(1)=node1;
      this.nodes_(2)=node2;
      this.nodes_(3)=node3;
      this.nodes_(4)=node4;
      this.numnode_=4;
    end% }}}

    function elemat = Evaluate(this)% {{{stiffness evaluation
      [gpx,gpw]=gaussrule('quad4',4);




      numDOF=size(4,1);
      elemat=zeros(8,8);
      elevec=zeros(8,1);


      for k=1:length(gpx)%begin gausspoint loop

        [J,detJ,invJ] = getJacobian(this.nodes_, gpx(k,1), gpx(k,2));

        dN_dxi=linquadderivref(gpx(k,1), gpx(k,2));
        N_xi=linquadref(gpx(k,1), gpx(k,2));
        dN_dx=dN_dxi*invJ;

        Bmat=[...
          dN_dx(1,1)         0  dN_dx(2,1)          0  dN_dx(3,1)         0  dN_dx(4,1)          0
                   0 dN_dx(1,2)          0 dN_dx(2,2)           0 dN_dx(3,2)          0 dN_dx(4,2)
          dN_dx(1,2) dN_dx(1,1) dN_dx(2,2) dN_dx(2,1)  dN_dx(3,2) dN_dx(3,1) dN_dx(4,2) dN_dx(4,1)];
        Cmat=[...
              1        this.nu_ 0
              this.nu_ 1        0
              0        0        1-this.nu_]*this.E_/(1-this.nu_^2);

        elemat=elemat+Bmat'*Cmat*Bmat*detJ*gpw(k);

      end%end gausspoint loop


    end% }}}

    function [] = Visualize(this,f)% {{{ Visualization function
      figure(f)
      hold on
      for iter=1:4
        plot3(this.nodes_(iter).X(),...
             this.nodes_(iter).Y(),...
             this.nodes_(iter).Z(),'ko');
      end

      plot3([this.nodes_(1).X(),this.nodes_(2).X()],...
            [this.nodes_(1).Y(),this.nodes_(2).Y()],...
            [this.nodes_(1).Z(),this.nodes_(2).Z()],'k-');
      plot3([this.nodes_(2).X(),this.nodes_(3).X()],...
            [this.nodes_(2).Y(),this.nodes_(3).Y()],...
            [this.nodes_(2).Z(),this.nodes_(3).Z()],'k-');
      plot3([this.nodes_(3).X(),this.nodes_(4).X()],...
            [this.nodes_(3).Y(),this.nodes_(4).Y()],...
            [this.nodes_(3).Z(),this.nodes_(4).Z()],'k-');
      plot3([this.nodes_(4).X(),this.nodes_(1).X()],...
            [this.nodes_(4).Y(),this.nodes_(1).Y()],...
            [this.nodes_(4).Z(),this.nodes_(1).Z()],'k-');

    end% }}}

  end

end
