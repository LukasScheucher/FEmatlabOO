function Kmat = Assemble(Kmat,elemat, dofs)

  Kmat(dofs,dofs)=Kmat(dofs,dofs)+elemat;
end
