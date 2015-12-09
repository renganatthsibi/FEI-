function [ab,ad,output]=FANNC_test(test_bags,test_target,theta_ij,alpha_ij,v_jh,w_hl,b,c,bias_c,bias_b,l_b)
[ni,~]=size(test_bags);
output=[];
ad=[];
ab=[];
ab2=[];
ad2=[];
for k=1:ni
          a=test_bags{k,1};
          d_e=test_target{k,1};
          [~,n_a]=size(a);
          [~,n_b]=size(b);
          [~,n_c]=size(c);
          if(k==91)
          end
          %% Input Internal Layer Assignment
          for j=1:n_b
               sBIn_j=0;
               for i=1:n_a
                 rb_ij(i,j)=((a(i)-theta_ij(i,j))/(alpha_ij(i,j)))^2;
                 BIn_ij(i,j)=exp(-rb_ij(i,j));
                 sBIn_j=sBIn_j+BIn_ij(i,j);
               end
               rb_j=-(sBIn_j-bias_b);
               b(j)=1/(1+exp(rb_j));
          end
          %% Output External Layer Assignment 
          for  h=1:n_c  
             sC_h=0;
             for j=1:n_b
               if(b(j)>l_b)
                   sC_h=sC_h+b(j)*v_jh(j,h);  %Leakage Competiton
               end 
             end
             [~,max_b_j]=max(b);
             rc_h=-(sC_h-bias_c);
             c(h)=1/(1+exp(rc_h)); 
          end
          [max_ch,max_h]=max(c);
          d=max_ch*w_hl(max_h,1);
          output=[output;d];
          
          if(d>0)
              ad=[ad;a];
          else
              ad2=[ad2;a];
          end
          
          if(d_e>0)
              ab=[ab;a];
          else
              ab2=[ab2;a];
          end
              
end
figure;
scatter(ab(:,1),ab(:,2),'filled');
hold all
scatter(ab2(:,1),ab2(:,2),'filled');
figure;
scatter(ad(:,1),ad(:,2),'filled');
hold all
scatter(ad2(:,1),ad2(:,2),'filled');
end
