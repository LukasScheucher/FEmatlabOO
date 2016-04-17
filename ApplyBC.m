function [LHS,RHS] = ApplyBC(LHS,RHS,dirichcond,neumanncond)

  LHS(dirichcond(:,1),:)=0;

  for iter=dirichcond(:,1)'
    LHS(iter,iter)=1.0;
  end

  RHS(dirichcond(:,1))=dirichcond(:,2);

  %neumanncond
  RHS(neumanncond(:,1))=neumanncond(:,2);


end
