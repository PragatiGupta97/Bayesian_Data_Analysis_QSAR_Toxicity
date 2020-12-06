data {
int < lower =1> N; // number of data points
vector [N] qr;// observation year
int <lower=1> J;
vector [J] x [N];

}
parameters {
  real alpha;
  vector [J] beta;
  
  real < lower =0> sigma ;
}
transformed parameters {
  vector [N] mu;
  for (i in 1:N)
  mu[i] = alpha + dot_product(x[i,:],beta');
}
model {
sigma ~ normal(0,100);
qr ~ normal (mu , sigma );

}
generated quantities {
//real ypred ;
vector[N] log_lik;
vector[N] gen_lik;
//Compute predictive distribution for the first machine
for (ind in 1:N)
{
log_lik[ind]= normal_lpdf(qr[ind] | mu[ind] ,sigma);
gen_lik[ind]= normal_rng (mu[ind] ,sigma);
};

}

