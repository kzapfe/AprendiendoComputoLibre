

function vdot(v,w,I)
    # Esta funcion es la derivada del voltaje
    #=
    esto es un comentario de varias
    lineas 
    =#
    result=0.0
    result=v-v^3-w+I

    return result
end

#forma corta de declarar una funcion
wdot(v, w)=(v+a-b*w)/tau
