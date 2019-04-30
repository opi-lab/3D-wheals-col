import sys
from skimage.feature import blob_log
import scipy.io

def get_centroids(path,mxs,ns,th):
      data = scipy.io.loadmat(path)
      Sp = data['Spz']
      blobs = blob_log(Sp, max_sigma=mxs, num_sigma=ns, threshold=th)
      return blobs

if __name__ == '__main__':
     path = str(sys.argv[1])
     mxs  = float(sys.argv[2])
     ns   = float(sys.argv[3])
     th   = float(sys.argv[4])
     sys.stdout.write(str(get_centroids(path,mxs,ns,th)))
