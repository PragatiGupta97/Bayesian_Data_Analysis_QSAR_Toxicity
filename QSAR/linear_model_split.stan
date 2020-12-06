data {

int < lower =1> N_train; // number of data points in train set
vector [N_train] qr_train;// quantitative response for train set 
int <lower=1> J; //number of features
vector [J] x_train [N_train]; //train dataset of explanatory variables

int < lower =1> N_test; //number of data points in test set

vector [J] x_test [N_test];///train dataset of explanatory variables


}
parameters {
  real alpha;
  vector [J] beta; 
  //beta is the vector containing cofficients for 8 exlanatory variables
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

// mu vector for test set
vector [N_test] mu_test;
//predicting the quantitive response for test set
vector [N_test] qr_test;
//log liklihood for train set
vector[N_train] log_lik;
//liklihood for train set
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









