function [output,theta_ij,alpha_ij,v_jh,w_hl,b,c,bias_c,bias_b,l_b]=FANNC_train (train_bags,train_target)
[ni,~]=size(train_bags);
l_b=0.8;
allow_err_d=0.11;
allow_err_c=0.11;
del=0.1;
b=1;
c=1;
bias_b=0.35;
bias_c=0.15;
alp=0.1;
output=[];
for k=1:ni
          a=train_bags{k,1};
          d_e=train_target{k,1};
          [~,n_a]=size(a);
          [~,n_b]=size(b);
          [~,n_c]=size(c);
          [~,n_d]=size(d_e);
           %% Intialization of Values
          if(k==1)
           BIn_ij=ones(n_a,n_b);
           rb_ij=ones(n_a,n_b);
           theta_ij=a';
           alpha_ij=alp*ones(n_a,n_b);
           v_jh=1;
           w_hl=d_e;
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
             [max_b,max_b_j]=max(b);
             rc_h=-(sC_h-bias_c);
             c(h)=1/(1+exp(rc_h)); 
          end
          [max_ch,max_h]=max(c);  %Third Layer compettion
          for l=1:n_d
              d(l)=max_ch*w_hl(max_h,l);
          end
          output=[output;d];  
          %%   Error Correcn
          err_d=0;
          for l=1:n_d
               err_d=err_d+(d_e(l)-d(l))^2;
          end     
          err_d=(1/(n_d))*(err_d);
          if(err_d<allow_err_d)    % error_d_allowable
                j=max_b_j;
                 for i=1:n_a
                      theta=theta_ij(i,j);
                      alpha=alpha_ij(i,j);
                      if(a(i)<(theta-0.3*alpha))
                          theta_ij(i,j)=(theta+0.3*alpha+a(i))/2;
                          alpha_ij(i,j)=(3*alpha-(10*a(i)-10*theta))/6;
                      elseif(a(i)>(theta+0.3*alpha))
                          theta_ij(i,j)=(theta-0.3*alpha+a(i))/2;
                          alpha_ij(i,j)=(3*alpha+(10*a(i)-10*theta))/6;
                      end
                 end
          else
              %% error_d_not-allowable
              err_c=[];
              for h=1:n_c
                  err_ch=(1/n_d)*sum((w_hl(h,:)-d_e)^2);
                  err_c=[err_c err_ch];
              end
              [err_c_min,c_min_h]=min(err_c);
              if(err_c_min<allow_err_c)  
                  %% error c allowable
                      %% Append one second unit
                      b=[b 1];
                      n_b=n_b+1;
                      theta_ij=[theta_ij,a'];
                      alpha_ij=[alpha_ij,alp*ones(length(a),1)];
                      v_jh(n_b,c_min_h)=1;
              else
                  %% Append two units
                  b=[b 1];
                  c=[c 1];
                      n_b=n_b+1;
                      n_c=n_c+1;
                      theta_ij=[theta_ij,a'];
                      alpha_ij=[alpha_ij,alp*ones(length(a),1)];
                      v_jh(n_b,n_c)=1;
                      w_hl=[w_hl;d_e];
                      
              end
          end       
end
end