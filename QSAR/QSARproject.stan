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
vector [N] C040;

}
parameters {
  real a;
  real b;
  real c;
  real d;
  real e; 
  real f;
  real g;
  real h;
  real i;
  real < lower =0> sigma ;
}
transformed parameters {
  vector [N] mu = a + b * TSPA + c * Saacc + d *H050 + e *MLOGP+ f*RDCHI +g*GATS1p
  + h*nN + i*C040;
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








