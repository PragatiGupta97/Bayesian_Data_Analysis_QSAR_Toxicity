data {
int < lower =1> N; // number of data points
vector [N] qr;// quantitative response
vector [N] TSPA;
vector [N] Saacc;
vector [N] H050;
vector [N] MLOGP;
vector [N] RDCHI;
vector [N] GATS1p;
vector [N] nN;
vector [N] C040;

int < lower =1> NP; // number of data points to be predicted
//vector [NP] qr_new;// quantitative response
vector [NP] TSPA_new;
vector [NP] Saacc_new;
vector [NP] H050_new;
vector [NP] MLOGP_new;
vector [NP] RDCHI_new;
vector [NP] GATS1p_new;
vector [NP] nN_new;
vector [NP] C040_new;



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

sigma ~ normal(0,100);
qr ~ normal (mu , sigma );

}
generated quantities {
//generated qr
vector [NP] mu_new= a + b * TSPA_new + c * Saacc_new + d *H050_new + 
e *MLOGP_new+ f*RDCHI_new +g*GATS1p_new+ h*nN_new + i*C040_new;

vector[NP] qr_predicted;
for (ind in 1:NP)
{
qr_predicted[ind]= normal_rng (mu_new[ind] ,sigma);
};


}








