data {
int < lower =1> N; // number of data points
vector [N] X2010;// observation year
vector [N] X2011;
vector [N] X2012;
vector [N] X2013;
vector [N] X2014;

}
parameters {
  real alpha ;
  real beta ;
  real gamma;
  real delta;
  real epsilon; 
  real < lower =0> sigma ;
}
transformed parameters {
  vector [N] mu = alpha + beta *X2010 + gamma *X2011 + delta *X2012 + epsilon *X2013;
}
model {
  
//beta ~ normal(0,26.74);
//alpha ~ normal(789,2523.813);
X2014 ~ normal (mu , sigma );

}
generated quantities {
//real ypred ;
vector[N] log_lik;
//Compute predictive distribution for the first machine
//ypred = normal_rng ( mu , sigma);
for (i in 1:N)
{
log_lik[i]= normal_lpdf(X2014[i] | mu ,sigma );
}
}








