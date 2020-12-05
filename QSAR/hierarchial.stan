data {
int < lower =1> N; // number of data points
vector [N] qr;// observation year
vector [N] TSPA;
vector [N] Saacc;
vector [N] H050;
vector [N] MLOGP;
vector [N] RDCHI;
vector [N] GATS1p;
vector [N] nN;
int C040[N];
int <lower = 0> nc; //number of carbon atoms //5 here 
//number of hierarchies

}
parameters {
  vector[nc] a; // 5 values
  vector[nc] b;
  vector[nc] c;
  vector[nc] d;
  vector[nc] e; 
  vector[nc] f;
  vector[nc] g;
  vector[nc] h;
  //vector[nc] i;
  real < lower =0> sigma ;
  //vector[nc] i;
  //hyper parameters
  real mu_a;real mu_b;real mu_c; real mu_d; real mu_e;real mu_f;
  real mu_g;real mu_h; real mu_i;
  real <lower= 0> tau_a;real <lower= 0> tau_b;real <lower= 0> tau_c;real <lower= 0> tau_d;
  real<lower= 0> tau_e;real <lower= 0> tau_f;
  real <lower= 0> tau_g;real <lower= 0> tau_h;real <lower= 0> tau_i;
 
}
transformed parameters {
  vector [N] mu;
  
  for(ind in 1:N)
  {
  mu[ind]= (a[C040[ind]+1]) + (b[C040[ind]+1]*TSPA[ind]) +
  (c[C040[ind]+1] * Saacc[ind]) + (d[C040[ind]+1]*H050[ind]) + (e[C040[ind]+1] *MLOGP[ind])+ 
  (f[C040[ind]+1]*RDCHI[ind]) + (g[C040[ind]+1]*GATS1p[ind]) + (h[C040[ind]+1]*nN[ind]) ;
  
  };
  
//+ i*C040;
//+ i*C040 + d*H050
}
model {
  
//beta ~ normal(0,26.74);
//alpha ~ normal(789,2523.813);
//a~ gamma(1,1);
//b~ gamma(1,1);
//c~ gamma(1,1);
//d~ gamma(1,1);
//e~ gamma(1,1);
//f~ gamma(1,1);
//g~ gamma(1,1);
//h~ gamma(1,1);
//i~ gamma(1,1);

//hyperpriors
mu_a~normal(0,0.1);
tau_a~ normal(0,1);

mu_b~normal(0,0.1);
tau_b~ normal(0,1);

mu_c~normal(0,0.1);
tau_c~ normal(0,1);

mu_d~normal(0,0.1);
tau_d~ normal(0,1);

mu_e~normal(0,0.1);
tau_e~ normal(0,1);

mu_f~normal(0,0.1);
tau_f~ normal(0,1);

mu_g~normal(0,0.1);
tau_g~ normal(0,1);

mu_h~normal(0,0.1);
tau_h~ normal(0,1);

mu_i~normal(0,0.1);
tau_i~ normal(0,1);


//priors
a~ normal(mu_a,tau_a);
b~ normal(mu_b,tau_b);
c~ normal(mu_c,tau_c);
d~ normal(mu_d,tau_d);
e~ normal(mu_e,tau_e);
f~ normal(mu_f,tau_f);
g~ normal(mu_g,tau_g);
h~ normal(mu_h,tau_h);

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








