data {
  
int < lower =1> N; // number of data points
vector [N] qr;
int <lower=1> J; //J will be 7 here instead of 8 of linear model
vector [J] x [N];
int C040[N];
int <lower = 0> nc; //number of carbon atoms //5 here 

}
parameters {
  vector[nc] alpha; // 5 values
  vector[J] beta [nc]; //5x7
  real < lower =0> sigma ;
  vector [J] mu_coff; //check
  vector <lower =0> [J] tau_coff; //check
  real <lower= 0> tau_a;
  real mu_a;
}
transformed parameters {
  vector [N] mu;
  for(ind in 1:N)
  {
  mu[ind]= alpha[C040[ind]+1] + dot_product(x[ind,:],beta[C040[ind]+1,]');

  };
  
}
model {
mu_a~normal(0,1);
tau_a~ normal(0,1);

for(j  in 1:J)
{
mu_coff[j]~normal(0,1);
tau_coff[j]~ normal(0,1);
}

//priors
alpha~ normal(mu_a,tau_a);

for(j in 1:J)
{
beta[,j] ~ normal(mu_coff[j],tau_coff[j]);
}

sigma ~ normal(0,100);
qr ~ normal (mu , sigma );

}
generated quantities {
//real ypred ;
vector[N] log_lik;
vector[N] gen_lik;
//Compute predictive distribution for the first machine
//ypred = normal_rng ( mu , sigma);
for (ind in 1:N)
{
log_lik[ind]= normal_lpdf(qr[ind] | mu[ind] ,sigma);
gen_lik[ind]= normal_rng (mu[ind] ,sigma);
};

}








