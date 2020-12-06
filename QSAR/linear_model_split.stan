data {

int < lower =1> N_train; // number of data points
vector [N_train] qr_train;// observation year
int <lower=1> J;
vector [J] x_train [N_train];

int < lower =1> N_test; // number of data points to be predicted

vector [J] x_test [N_test];


}
parameters {
  real alpha;
  vector [J] beta;
  real < lower =0> sigma ;
}
transformed parameters {
  vector [N_train] mu_train;
  for (i in 1:N_train)
  mu_train[i] = alpha + dot_product(x_train[i,:],beta');
  
}
model {

sigma ~ normal(0,100);
qr_train ~ normal (mu_train , sigma );

}
generated quantities {

vector [N_test] mu_test;
vector [N_test] qr_test;
vector[N_train] log_lik;
vector[N_train] gen_lik;

for (i in 1:N_test)
{mu_test[i] = alpha + dot_product(x_test[i,:],beta');};

for (ind in 1:N_test)
{
qr_test[ind]= normal_rng (mu_test[ind] ,sigma);
};

for (ind in 1:N_train)
{
log_lik[ind]= normal_lpdf(qr_train[ind] | mu_train[ind] ,sigma);
gen_lik[ind]= normal_rng (mu_train[ind] ,sigma);
};

}









