classdef InputReaderGmsh < handle
  %this should be done via regular expressions which I am no cabable of right now

  properties(Access=private)
  end

  methods(Access = public)
    function this = InputReaderGmsh(dummy)% {{{ctor
    end% }}}

    function [] = ReadInput(this,disobj,filepath)% {{{ReadInput function

      fid = fopen(filepath);
      tline = fgets(fid);
      curlinenum=1;
      while tline~=-1% {{{ begin file loop
        if strfind(tline,'$Elements')>0
          numele=fgets(fid);
          eleline=fgets(fid);
          while isempty(strfind(eleline,'$EndElements'))
            nums=str2num(eleline);

            if nums(2)==3% Quad4 case
              newelement=EleQuad4(nums(1),...                  %ID
                                  disobj.gNode(nums(end-3)),...%node1
                                  disobj.gNode(nums(end-2)),...%node2
                                  disobj.gNode(nums(end-1)),...%node3
                                  disobj.gNode(nums(end-0)));  %node4
              newelement.setE(1.0);
              newelement.setnu(0.3);
              disobj.AddElement(newelement);
            end

            eleline=fgets(fid);%get the next email
          end
        end

        if strfind(tline,'$Nodes')>0
          disp(['Now reading the following number of elements: ',fgets(fid)]);
          tline=fgets(fid);
          while isempty(strfind(tline,'$EndNodes'))
            nums=str2num(tline);
            newnode=NodeBase(nums(1),nums(2),nums(3),nums(4));
            disobj.AddNode(newnode);
            tline=fgets(fid);
          end
        end

        tline = fgets(fid);
        curlinenum=curlinenum+1;
      end% }}} end file loop
      
    end% }}}end ReadInput function

    function [] = AddEleFromLine()
    end

  end%end methods

end

