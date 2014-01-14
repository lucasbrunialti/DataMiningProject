DataMiningProject
=================

Instructions for running algorithms:


PCA
===
* X -> dataset
* reduceTo -> number of dimensions to reduce

``[ XReduced, eigenvals, eigenvecs ] = pca( X, reduceTo )``


MLP
===
* X_train -> training dataset
* expected_train -> training dataset labels
* X_test -> test dataset
* expected_test -> test dataset labels
* X_val -> validation dataset
* expected_val -> validation dataset labels
* num_epochs -> stop criteria, number of epochs
* validation_checks -> stop criteria, number of validations

``[ W1_epochs, W2_epochs, B1_epochs, B2_epochs, mse_train, mse_test, mse_val ] =``
``backpropagation( X_train, expected_train, X_test, expected_test, X_val, expected_val, ``
``num_epochs, validation_checks, num_neurons_hid, num_neurons_output, learning_rate, momentum, learning_rate_incr, learning_rate_dec)``


DBSCAN
======
Compile
-------
``javac Point.java Dbscan.java``

Running
-------
``java Dbscan <eps> <minPoints> <path_to_dataset>``

* eps -> neighborhood radius
* minPoints -> minimum points to create a core cluster
* path_to_dataset -> path to a txt file separated by \t
