function test(s)

disp('testing')
load ('featureout.mat');
p=featureout;
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
load net.mat;
load net;
y5=sim(net,p);
disp(y5);
[C, I]=max(y5);
disp(I)
disp(C)
fid = fopen('output.txt','a');
if s==3
    if (I==1)
        fprintf(fid,'0');
        fclose(fid);
    elseif (I==2)
        fprintf(fid,'1');
        fclose(fid);
    elseif (I==3)
        fprintf(fid,'2');
        fclose(fid);
    elseif (I==4)
        fprintf(fid,'3');
        fclose(fid);
    elseif (I==5)
        fprintf(fid,'4');
        fclose(fid);
    elseif (I==6)
        fprintf(fid,'5');
        fclose(fid);
    elseif (I==7)
        fprintf(fid,'6');
        fclose(fid);
    elseif (I==8)
        fprintf(fid,'7');
        fclose(fid);
    elseif (I==9)
        fprintf(fid,'8');
        fclose(fid);
    elseif (I==10)
        fprintf(fid,'9');
        fclose(fid);
    else
        disp(' not Found');
        clear
    end
    
elseif s==1
    
    if (I==1)
        fprintf(fid,'A');
        fclose(fid);
    elseif (I==2)
        fprintf(fid,'B');
        fclose(fid);
    elseif (I==3)
        fprintf(fid,'C');
        fclose(fid);
    elseif (I==4)
        fprintf(fid,'D');
        fclose(fid);
    elseif (I==5)
        fprintf(fid,'E');
        fclose(fid);
    elseif (I==6)
        fprintf(fid,'F');
        fclose(fid);
    elseif (I==7)
        fprintf(fid,'G');
        fclose(fid);
    elseif (I==8)
        fprintf(fid,'H');
        fclose(fid);
    elseif (I==9)
        fprintf(fid,'I');
        fclose(fid);
    elseif (I==10)
        fprintf(fid,'J');
        fclose(fid);
    elseif (I==11)
        fprintf(fid,'K');
        fclose(fid);
    elseif (I==12)
        fprintf(fid,'L');
        fclose(fid);
    elseif (I==13)
        fprintf(fid,'M');
        fclose(fid);
    elseif (I==14)
        fprintf(fid,'N');
        fclose(fid);
    elseif (I==15)
        fprintf(fid,'O');
        fclose(fid);
    elseif (I==16)
        fprintf(fid,'P');
        fclose(fid);
    elseif (I==17)
        fprintf(fid,'Q');
        fclose(fid);
    elseif (I==18)
        fprintf(fid,'R');
        fclose(fid);
    elseif (I==19)
        fprintf(fid,'S');
        fclose(fid);
    elseif (I==20)
        fprintf(fid,'T');
        fclose(fid);
    elseif (I==21)
        fprintf(fid,'U');
        fclose(fid);
    elseif (I==22)
        fprintf(fid,'V');
        fclose(fid);
    elseif (I==23)
        fprintf(fid,'W');
        fclose(fid);
    elseif (I==24)
        fprintf(fid,'X');
        fclose(fid);
    elseif (I==25)
        fprintf(fid,'Y');
        fclose(fid);
    elseif (I==26)
        fprintf(fid,'Z');
        fclose(fid);
    else
        disp(' not Found');
        clear
    end
    
elseif s==2
    
    if (I==1)
        fprintf(fid,'a');
        fclose(fid);
    elseif (I==2)
        fprintf(fid,'b');
        fclose(fid);
    elseif (I==3)
        fprintf(fid,'c');
        fclose(fid);
    elseif (I==4)
        fprintf(fid,'d');
        fclose(fid);
    elseif (I==5)
        fprintf(fid,'e');
        fclose(fid);
    elseif (I==6)
        fprintf(fid,'f');
        fclose(fid);
    elseif (I==7)
        fprintf(fid,'g');
        fclose(fid);
    elseif (I==8)
        fprintf(fid,'h');
        fclose(fid);
    elseif (I==9)
        fprintf(fid,'i');
        fclose(fid);
    elseif (I==10)
        fprintf(fid,'j');
        fclose(fid);
    elseif (I==11)
        fprintf(fid,'k');
        fclose(fid);
    elseif (I==12)
        fprintf(fid,'l');
        fclose(fid);
    elseif (I==13)
        fprintf(fid,'m');
        fclose(fid);
    elseif (I==14)
        fprintf(fid,'n');
        fclose(fid);
    elseif (I==15)
        fprintf(fid,'o');
        fclose(fid);
    elseif (I==16)
        fprintf(fid,'p');
        fclose(fid);
    elseif (I==17)
        fprintf(fid,'q');
        fclose(fid);
    elseif (I==18)
        fprintf(fid,'r');
        fclose(fid);
    elseif (I==19)
        fprintf(fid,'s');
        fclose(fid);
    elseif (I==20)
        fprintf(fid,'t');
        fclose(fid);
    elseif (I==21)
        fprintf(fid,'u');
        fclose(fid);
    elseif (I==22)
        fprintf(fid,'v');
        fclose(fid);
    elseif (I==23)
        fprintf(fid,'w');
        fclose(fid);
    elseif (I==24)
        fprintf(fid,'x');
        fclose(fid);
    elseif (I==25)
        fprintf(fid,'y');
        fclose(fid);
    elseif (I==26)
        fprintf(fid,'z');
        fclose(fid);
    else
        disp(' not Found');
        clear
    end
    
elseif s==4
    
    if (I==1)
        fprintf(fid,'0');
        fclose(fid);
    elseif (I==2)
        fprintf(fid,'1');
        fclose(fid);
    elseif (I==3)
        fprintf(fid,'2');
        fclose(fid);
    elseif (I==4)
        fprintf(fid,'3');
        fclose(fid);
    elseif (I==5)
        fprintf(fid,'4');
        fclose(fid);
    elseif (I==6)
        fprintf(fid,'5');
        fclose(fid);
    elseif (I==7)
        fprintf(fid,'6');
        fclose(fid);
    elseif (I==8)
        fprintf(fid,'7');
        fclose(fid);
    elseif (I==9)
        fprintf(fid,'8');
        fclose(fid);
    elseif (I==10)
        fprintf(fid,'9');
        fclose(fid);
    elseif (I==11)
        fprintf(fid,'A');
        fclose(fid);
    elseif (I==12)
        fprintf(fid,'B');
        fclose(fid);
    elseif (I==13)
        fprintf(fid,'C');
        fclose(fid);
    elseif (I==14)
        fprintf(fid,'D');
        fclose(fid);
    elseif (I==15)
        fprintf(fid,'E');
        fclose(fid);
    elseif (I==16)
        fprintf(fid,'F');
        fclose(fid);
    elseif (I==17)
        fprintf(fid,'G');
        fclose(fid);
    elseif (I==18)
        fprintf(fid,'H');
        fclose(fid);
    elseif (I==19)
        fprintf(fid,'I');
        fclose(fid);
    elseif (I==20)
        fprintf(fid,'J');
        fclose(fid);
    elseif (I==21)
        fprintf(fid,'K');
        fclose(fid);
    elseif (I==22)
        fprintf(fid,'L');
        fclose(fid);
    elseif (I==23)
        fprintf(fid,'M');
        fclose(fid);
    elseif (I==24)
        fprintf(fid,'N');
        fclose(fid);
    elseif (I==25)
        fprintf(fid,'O');
        fclose(fid);
    elseif (I==26)
        fprintf(fid,'P');
        fclose(fid);
    elseif (I==27)
        fprintf(fid,'Q');
        fclose(fid);
    elseif (I==28)
        fprintf(fid,'R');
        fclose(fid);
    elseif (I==29)
        fprintf(fid,'S');
        fclose(fid);
    elseif (I==30)
        fprintf(fid,'T');
        fclose(fid);
    elseif (I==31)
        fprintf(fid,'U');
        fclose(fid);
    elseif (I==32)
        fprintf(fid,'V');
        fclose(fid);
    elseif (I==33)
        fprintf(fid,'W');
        fclose(fid);
    elseif (I==34)
        fprintf(fid,'X');
        fclose(fid);
    elseif (I==35)
        fprintf(fid,'Y');
        fclose(fid);
    elseif (I==36)
        fprintf(fid,'Z');
        fclose(fid);
    elseif (I==37)
        fprintf(fid,'a');
        fclose(fid);
    elseif (I==38)
        fprintf(fid,'b');
        fclose(fid);
    elseif (I==39)
        fprintf(fid,'c');
        fclose(fid);
    elseif (I==40)
        fprintf(fid,'d');
        fclose(fid);
    elseif (I==41)
        fprintf(fid,'e');
        fclose(fid);
    elseif (I==42)
        fprintf(fid,'f');
        fclose(fid);
    elseif (I==43)
        fprintf(fid,'g');
        fclose(fid);
    elseif (I==44)
        fprintf(fid,'h');
        fclose(fid);
    elseif (I==45)
        fprintf(fid,'i');
        fclose(fid);
    elseif (I==46)
        fprintf(fid,'j');
        fclose(fid);
    elseif (I==47)
        fprintf(fid,'k');
        fclose(fid);
    elseif (I==48)
        fprintf(fid,'l');
        fclose(fid);
    elseif (I==49)
        fprintf(fid,'m');
        fclose(fid);
    elseif (I==50)
        fprintf(fid,'n');
        fclose(fid);
    elseif (I==51)
        fprintf(fid,'o');
        fclose(fid);
    elseif (I==52)
        fprintf(fid,'p');
        fclose(fid);
    elseif (I==53)
        fprintf(fid,'q');
        fclose(fid);
    elseif (I==54)
        fprintf(fid,'r');
        fclose(fid);
    elseif (I==55)
        fprintf(fid,'s');
        fclose(fid);
    elseif (I==56)
        fprintf(fid,'t');
        fclose(fid);
    elseif (I==57)
        fprintf(fid,'u');
        fclose(fid);
    elseif (I==58)
        fprintf(fid,'v');
        fclose(fid);
    elseif (I==59)
        fprintf(fid,'w');
        fclose(fid);
    elseif (I==60)
        fprintf(fid,'x');
        fclose(fid);
    elseif (I==61)
        fprintf(fid,'y');
        fclose(fid);
    elseif (I==62)
        fprintf(fid,'z');
        fclose(fid);
    else
        disp(' not Found');
        clear
    end
    
end