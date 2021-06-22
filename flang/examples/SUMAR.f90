PROGRAM SUMAR 
  INTEGER :: N = 0
  INTEGER :: I
  INTEGER :: SUMA

  write (*,*) 'Capture el número: '
  read (*,*) N

  SUMA = 0

  DO I = 1, N
    SUMA = SUMA + I
  END DO
 
  WRITE(6, *) "Suma =", SUMA
END PROGRAM SUMAR