close all
clear
clc

tic

corners=[...
  0    0
  2    0
  2    0.5
  0    0.5];


dis1=Discretization();
gen1=RectQuadMeshGenerator()
gen1.setCorners(corners)
gen1.setNumEle12(24)
gen1.setNumEle14(12)
gen1.setEleType('quad4')

gen1.genMesh(dis1);

dis1.SetBoundaryCondRange('dirich',[1 2],[0 0],...
                          [0 0.0],[-inf inf],[-inf inf])

dis1.SetBoundaryCondRange('dirich',[1 2],[0 0],...
                          [2.0 2.0],[-inf inf],[-inf inf])

dis1.SetBoundaryCondRange('neumann',[2],[0.4],...
                          [1.0 1.0],[-inf inf],[-inf inf])

time1=toc
tic


%% begin actual calculation

numnode=dis1.NumNode();
numele =dis1.NumEle();

LHS=sparse(numnode*2,numnode*2);
RHS=sparse(numnode*2,1);

for iterele=1:numele
  dofs=dis1.gElement(iterele).gDofs();
  LHS=Assemble(LHS,dis1.gElement(iterele).Evaluate(),dofs);
end


[LHS,RHS] = ApplyBC(LHS,RHS,dis1.gDirichCond(),dis1.gNeumannCond());

sol=LHS\RHS;
time=toc

f1=figure();
dis1.Visualize(f1);
dis1.VisualizeBC(f1);

dis1.ApplyDisp(sol*1);

f2=figure();
axis equal
dis1.Visualize(f2)
