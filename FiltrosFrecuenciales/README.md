### Filtros Frecuenciales

Para los filtros frecuenciales mediante la transformada de fourier se aplican los siguientes pasos:

1. Calcular la transformada de fourier de la imagen.
2. Multiplicar la transformada por el filtro.
3. Calcular la transformada inversa de fourier.

$$
G(u,v) = H(u,v) *F(u,v)
$$



Fitro ideal:
$$
D(u,v) = \sqrt{x^2 + y^2}
$$

#### Filtro Pasa-Bajo

Ecuación:
$$
H(u,v) = \{ \begin{array}{c} 1 \hspace{0.3cm} si \hspace{0.3cm} D(u,v)<D_{0}\\ 0 \hspace{0.3cm} si \hspace{0.3cm} D(u,v)>D_{0}\end{array}
$$

#### Filtro Butterworth

Ecuación:
$$
H(u,v) = \frac{1}{1 + [\sqrt{2-1}][D(u,v)/D_{0}]^2}
$$

#### Filtro Pasa-Alto

Ecuacion:
$$
H(u,v) = \{ \begin{array}{c} 0 \hspace{0.3cm} si \hspace{0.3cm} D(u,v)<D_{0}\\ 1 \hspace{0.3cm} si \hspace{0.3cm} D(u,v)>D_{0}\end{array}
$$
