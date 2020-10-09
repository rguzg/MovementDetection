% Diferencia de imagenes
% Entradas: imagen1, imagen2
% Salidas: IDif: imagen de diferencia, maxDif: valor máximo de
% diferencia

function [IDif, maxDif] = RestaImagenes(imagen1, imagen2)
    IDif = 0;
    maxDif = 0;

  if (size(imagen1,1) == size(imagen2,1)) && (size(imagen1,1) == size(imagen2,1)) && (size(imagen1,3) == size(imagen2,3))
      % Se convierte a double para que si un resultado fuera negativo se
      % represente correctamente y no como 0. Osea que 150-200 nos de -50
      IDif = abs(double(imagen1) - double(imagen2));
      maxDif = max(IDif(:));
  end
  
  IDif = uint8(IDif);
end

