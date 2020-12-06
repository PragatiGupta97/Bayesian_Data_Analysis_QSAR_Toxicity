data {
  
int < lower =1> N; // number of data points
vector [N] qr; //quantitative response
int <lower=1> J; //J will be 7 excluding c040 
//here instead of 8 of linear model
vector [J] x [N]; // dataset of explanatory variables
int C040[N]; //data for C040 feature
int <lower = 0> nc; //number of distinct C040(5 here) 

}
parameters {
  vector[nc] alpha; // 5 values for 5 distince C040
  vector[J] beta [nc]; //5x7 matrix
  real < lower =0> sigma ;
  
  //hyperparameters declaration
  vector [J] mu_coff; 
  vector <lower =0> [J] tau_coff;
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
//setting priors for paramters and hyperparameters
mu_a~normal(0,1);
tau_a~ normal(0,1);

for(j  in 1:J)
{
mu_coff[j]~normal(0,1);
tau_coff[j]~ normal(0,1);
}

alpha~ normal(mu_a,tau_a);

for(j in 1:J)
{
beta[,j] ~ normal(mu_coff[j],tau_coff[j]);
}

sigma ~ normal(0,100);

//liklihood
qr ~ normal (mu , sigma );

}
generated quantities {
//log liklihood for data set;
vector[N] log_lik;
//liklihood for the dataset
vector[N] gen_lik;
for (ind in 1:N)
{
log_lik[ind]= normal_lpdf(qr[ind] | mu[ind] ,sigma);
gen_lik[ind]= normal_rng (mu[ind] ,sigma);
};

}








