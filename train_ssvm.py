import csv
import numpy
from pystruct.models import GraphCRF
from pystruct.learners import OneSlackSSVM

edge_list = []
edge_attributes = []
edge_labels = []

with open("edge_features.txt") as f :
   reader = csv.reader(f, delimiter = ' ')
   reader.next()
   for row in reader :
       edge_list.append((int(row[0]), int(row[1])))
       try :
           edge_attributes.append((float(row[2]),))
       except ValueError :
           edge_attributes.append((numpy.nan,))
       edge_labels.append(int(row[3]))

Y = (numpy.array(edge_labels),)
X = numpy.array(edge_attributes)

E = numpy.empty((0, 2), dtype=numpy.int)
X = ((X, E),)

model = GraphCRF(n_features=1, n_states=2, inference_method='ad3')
svm = OneSlackSSVM(model, verbose=1)

print "hello"
print X
print zip(X, Y)[0]

#print X[0].shape
#print Y.shape
svm.fit(X, Y)
                         
