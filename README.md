pystruct-neighborhood-spike
===========================

Spike for using pystruct to learn factors that contribute to neighborhood boundaries

```bash
> python train_ssvm.py
Training 1-slack dual structural SVM
iteration 0
OneSlackSSVM(C=1.0, break_on_bad=False, cache_tol=auto,
       check_constraints=True, inactive_threshold=1e-10,
       inactive_window=50, inference_cache=0, logger=None, max_iter=100,
       model=GraphCRF(n_states: 2, inference_method: ad3), n_jobs=1,
       positive_constraint=None, show_loss_every=0, switch_to=None,
       tol=1e-05, verbose=1)
Traceback (most recent call last):
  File "train_ssvm.py", line 30, in <module>
    svm.fit(X, Y)
  File "/mnt/ide0/home/fgregg/public/pystruct/pystruct/learners/one_slack_ssvm.py", line 460, in fit
    n_samples=len(X))
  File "/mnt/ide0/home/fgregg/public/pystruct/pystruct/learners/one_slack_ssvm.py", line 181, in _solve_1_slack_qp
    solution = cvxopt.solvers.qp(P, q, G, h, A, b)
  File "/home/fgregg/lib64/python2.6/site-packages/cvxopt/coneprog.py", line 4496, in qp
    return coneqp(P, q, G, h, None, A,  b, initvals)
  File "/home/fgregg/lib64/python2.6/site-packages/cvxopt/coneprog.py", line 2082, in coneqp
    raise ValueError("Rank(A) < p or Rank([P; A; G]) < n")
ValueError: Rank(A) < p or Rank([P; A; G]) < n
```

The attributes have a number of numpy nans.
