%%
res=load('res7');
res=res.res6;
PDF_e=histogram(res.V_e,[-69:1:100],'normalization','probability');
PDF_e=PDF_e.Values;
close;
PDF_i=histogram(res.V_i,[-69:1:100],'normalization','probability');
PDF_i=PDF_i.Values;
close;
% % 
% PDF_e=gaussian_vector(10.5402,-1.7394);
% PDF_i=gaussian_vector(13.3019,-2.0295);


p1=zeros(1,76);
p2=zeros(1,26);
p3=zeros(1,76);
p4=zeros(1,26);

p5=zeros(1,76);
p6=zeros(1,26);
p7=ones(1,76);
p8=zeros(1,26);
p9=ones(1,76);
p10=ones(1,26);

for i=1:76
    j=169;
    count=0;
    if i==1
        lim=0.5/75;
    else
        lim=(i-1)/75;
    end
    while count<lim && j>1
        count=sum(PDF_e(j: min(j+25,169)));
        j=j-1;
    end
    p1(i)=PDF_e(j)/(1-count);
    if j+25>169
        p3(i)=0;
    else
        p3(i)=PDF_e(j+25)/count;
    end
%     p3(i)=PDF_e(min(j+25,169))/count;
    p5(i)=sum(PDF_e(max(j-25,1):min(j,169)))/(1-count);
end

for i=1:26
    j=169;
    count=0;
    if i==1
        lim=0.5/25;
    else
        lim=(i-1)/25;
    end
    while count<lim && j>1
        count=sum(PDF_e(j: min(j+25,169)));
        j=j-1;
    end
    p2(i)=PDF_i(j)/(1-count);
    if j+25>169
        p4(i)=0;
    else
        p4(i)=PDF_i(j+25)/count;
    end
%     p4(i)=PDF_i(min(j+25,169))/count;
    p6(i)=sum(PDF_i(max(j-10,1):j))/(1-count);
    if j+15 >169
        p8(i)=0;
    else
        p8(i)=sum(PDF_i(j+15:min(j+25,169)))/count;
    end
%     p8(i)=sum(PDF_i(min(j+10,169):min(j+25,169)))/count;
end
    

    

P1.P_BE_Ex = p1;
P1.P_BI_Ex = p2;
P1.P_GE_Ex = p3;
P1.P_GI_Ex = p4;
P1.P_BE_E = p5;
P1.P_BI_E = p6;
P1.P_GE_E = p7;
P1.P_GI_E = p8;
P1.P_GE_I = p9;
P1.P_GI_I = p10;





%%

s=ones(1,4); %representing (N_ge,N_gi,H_e,H_i)

%  c=0.3;
 r=100;
 p1=p1*1.0;%p^ext_bge
 p2=p2*0.5;%p^ext_bgi
 p3=p3*1;  %p^ext_gsbe
 p4=p4*1;  %p^ext_gsbi
 p5=p5*0.42;%p^pe_bge
 p6=p6*0.7;%p^pe_bgi
 p8=p8*1.3;


P_e=24;
P_i=48;

lambda_e=1/7;
lambda_i=1/7;
tau_ee=1.3;
tau_ie=0.95;
tau_i=4.5;
a_ee=0.55;
a_ie=0.45;
a_ei=0.79;
a_ii=0.21;





t=0;
duration_time=1000;
spike=zeros(2,2000);


rec=zeros(5,1000);
count=0;

while t<= duration_time
    c=[p1(s(1)+1)/lambda_e,p2(s(2)+1)/lambda_i,p3(s(1)+1)/lambda_e,p4(s(2)+1)/lambda_i,...
        p5(s(1)+1)*a_ee/tau_ee,p6(s(2)+1)*a_ie/tau_ie,p7(s(1)+1)*a_ee/tau_ee,p8(s(2)+1)*a_ie/tau_ie,0,...
        p9(s(1)+1)*a_ei/tau_i,p10(s(2)+1)*a_ii/tau_i,0];
    q=[75-s(1),25-s(2),s(1),s(2),(1-s(1)/75)*s(3),(1-s(2)/25)*s(3),s(1)*s(3)/75,...
        s(2)*s(3)/25,0,s(1)*s(4)/75,s(2)*s(4)/25,0];
    q=q.*c;
    q(9)=(1-s(1)/75)*s(3)*(1-p5(s(1)+1))*a_ee/tau_ee+(1-s(2)/25)*s(3)*a_ie/tau_ie*(1-p6(s(2)+1))...
        +s(1)*s(3)/75*a_ee/tau_ee*(1-p7(s(1)+1))+s(2)*s(3)/25*a_ie/tau_ie*(1-p8(s(2)+1));
    q(12)=s(4)/tau_i-q(10)-q(11);
    dt=exprnd(1/sum(q));
    t=t+dt;
    if floor(t)-floor((t-dt))==1
        t
        count=count+1;
        rec(:,count)=[s,t-dt]';
    end
    q=q/sum(q);
    d=rand(1);
    per=q(1);
    i=1;
    while per<d
        i=i+1;
        per=per+q(i);
    end
    if i==1
        s(1)=s(1)+1;
    elseif i==2
        s(2)=s(2)+1;
    elseif i==3
        s(1)=s(1)-1;
        s(3)=s(3)+P_e;
        spike(1,1)=spike(1,1)+1;
        spike(1,spike(1,1)+1)=t;
        if s(3)>r*2000
            s(3)=r*2000;
        end
    elseif i==4
        s(2)=s(2)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>r*4000
            s(4)=r*4000;
        end
    elseif i==5
        s(1)=s(1)+1;
        s(3)=s(3)-1;
    elseif i==6
        s(2)=s(2)+1;
        s(3)=s(3)-1;
    elseif i==7
        s(1)=s(1)-1;
        s(3)=s(3)-1+P_e;
        spike(1,1)=spike(1,1)+1;
        spike(1,spike(1,1)+1)=t;
        if s(3)>r*2000
            s(3)=r*2000;
        end
    elseif i==8
        s(2)=s(2)-1;
        s(3)=s(3)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>r*4000
            s(4)=r*4000;
        end
    elseif i==9
        s(3)=s(3)-1;
    elseif i==10
        s(1)=s(1)-1;
        s(4)=s(4)-1;
    elseif i==11
        s(2)=s(2)-1;
        s(4)=s(4)-1;
    elseif i==12
        s(4)=s(4)-1;
    end
    
    
end

scatter(spike(1,2:spike(1,1)+1), 1*ones(1,spike(1,1)),'.','r');
hold on
scatter(spike(2,2:spike(2,1)+1), 2*ones(1,spike(2,1)),'.','b');
hold on
plot(rec(5,:),rec(1,:)/75+1.2);
hold on
plot(rec(5,:),rec(2,:)/25+1.2);
hold on
plot(rec(5,:),rec(3,:)/(r*4000));
hold on
plot(rec(5,:),rec(4,:)/(r*4000));

legend('spikes of E','spikes of I','N_{ge}/75','N_{gi}/25','H_e/20000','H_i/20000');

% hold on
% scatter(spike(2,2:spike(2,1)+1), 2*ones(1,spike(2,1)),'.','b');


    
                                    
            
    


