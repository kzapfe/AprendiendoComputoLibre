"""
Esta es la documntack

"""

import numpy as np
from matplotlib import pyplot as plt
from matplotlib import animation


fmax=1000
tantos=20


# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()

ax = plt.axes(xlim=(0, 1), ylim=(0, 1))

line1, = ax.plot([], [], lw=2)
line2, =ax.plot([], [], lw=1, c="red")

line3, =ax.plot([0,1],[0,1], lw=2)

# initialization function: plot the background of each frame
def init():
    line1.set_data([], [])
    line2.set_data([], [])
    return line1, line2,

def mapeo(x,k):
    xp=x*k*(1.0-x)
    return xp
    
# animation function.  This is called sequentially
def animate(i):

    x = np.linspace(0, 1, 1000)
    
    xini=0.123812908    
    a=np.empty(tantos)*0.0
    
    a[0]=xini
    
    k = 1.0*i/fmax+3.0
    y = x*k*(1.-x)
    
    for t in range(1,tantos):
        a[t]=mapeo(a[t-1],k)
    
    
    a=np.repeat(a,2)
    ap=np.roll(a,-1)
    ap[-1]=mapeo(ap[-2],k)
    ap[0]=0

  #  print("esto es a ", a, "\n")
  #  print("esto es ap final ", ap[-1], "\n")
    
    line1.set_data(x, y)
    line2.set_data(a,ap)
    return line1, line2, line3

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=fmax, interval=100, blit=True)

plt.show()
