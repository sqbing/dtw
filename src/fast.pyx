import numpy as np
import numpy.linalg as la
cimport numpy as np
DTYPE = np.double
ctypedef np.double_t DTYPE_t

def dtw_fast(np.ndarray s, np.ndarray t):
    
    cdef int nrows = s.shape[0]
    cdef int ncols = t.shape[0]
    
    cdef np.ndarray dtw = np.zeros((nrows+1,ncols+1), dtype = DTYPE)

    dtw[:,0] = 1e6
    dtw[0,:] = 1e6
    dtw[0,0] = 0.0
    
    cdef unsigned int i,j
    cdef DTYPE_t cost
    
    for i in range(nrows):
        for j in range(ncols):
            cost = la.norm(s[i] - t[j])
            dtw[i+1,j+1] = cost + np.min([dtw[i,j+1],dtw[i+1,j],dtw[i,j]])

    return dtw[nrows,ncols]
