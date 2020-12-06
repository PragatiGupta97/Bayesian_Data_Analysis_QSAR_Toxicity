
data {
  int <lower=0> J;
  // observe data
  int <lower=0> N1;
  vector [J] x1[N1];
  vector [N1] y1;
  // test data
  int <lower=0> N2;
  vector [J] x2[N2];
}

transformed data {
  int<lower=1> N = N1 + N2;
  vector[J] x[N]; //number all
  for (n1 in 1:N1) x[n1] = x1[n1];
  for (n2 in 1:N2) x[N1 + n2] = x2[n2];
}

parameters {
  real <lower=0> rho;
  real <lower=0> alpha;
  real <lower=0> sigma;
  vector[N] eta;
}

transformed parameters {
  vector[N] f;
  {
    matrix[N,N] K = cov_exp_quad(x, alpha, rho) + diag_matrix(rep_vector(square(sigma), N));
    matrix[N,N] L_K = cholesky_decompose(K);
    f = L_K * eta;
  }
}

model {
  // prior
  rho ~ inv_gamma(5, 5);
  alpha ~ normal(0, 1);
  sigma ~ normal(0, 1);
  eta ~ normal(0, 1);
  
  // likelihood
  y1 ~ normal(f[1:N1], sigma);
}

generated quantities {
  vector[N1] pred_y1;
  vector[N2] y2;
  vector[N1] log_lik;
  
  // predictive assessment
  for(n2 in 1:N2)
    y2[n2] = normal_rng(f[N1 + n2], sigma);
  
  // log likelihood
  for (n1 in 1:N1)
    log_lik[n1]= normal_lpdf(y1[n1] | f[n1] ,sigma );
    
  // posterior predictive check
  for(n1 in 1:N1)
    pred_y1[n1] = normal_rng(f[n1], sigma);
}

