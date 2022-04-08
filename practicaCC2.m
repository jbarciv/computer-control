%*********************************************
%          CONTROL POR COMPUTADOR            
%   PRÁCTICA 2: IDENTIFICACIÓN DE SISTEMAS   
%*********************************************

function [MisDatos, Gs, Gz, Proceso, ARX] = practicaCC2()

%% Creación de la variable MisDatos tipo struct.
MisDatos.nombre='Josep';
MisDatos.apellidos='Barbera';
MisDatos.DNI=06285214;
MisDatos.nmat=99999;
MisDatos.horas=12;
%% Cargado de datos
load('ensayo8.mat','in','out','t');
data = iddata(out,in,0.5);
%% Filtrado de datos
dataf = idfilt(data,5,0.1);
%in_f = dataf.u; %(por si fuera de utilidad) 
out_f = dataf.y;
%--------------------------------------------------------
%% Gs, variable con el modelo continuo identificado                 
% Obtenida mediante 'Transfer Function Model' con 2 polos y 0 ceros.
% El filtrado mejora el fitting -> se ha recalculado el modelo.
Options = tfestOptions;                   
Options.EnforceStability = true;          
Gs = tfest(dataf, 2, 0, Options);
%------------------------------------------------------
%% Gz, variable con el modelo discreto identificado.
% Obtenida mediante 'Transfer Function Model' con 3 polos y 0 ceros.
% El filtrado no mejora el modelo.
Options = tfestOptions;                      
Options.EnforceStability = true;
Gz = tfest(data, 3, 0, Options, 'Ts', 0.5);
%------------------------------------------------------
%% Proceso, variable con el modelo de proceso identificado.
% Obtenida mediante 'Process Models' con 2 polos complejos subamortiguados.
% El filtrado no mejora significativamente el modelo.
Opt = procestOptions;                    
Proceso = procest(dataf,'P2U', Opt);
%------------------------------------------------------
%% ARX, variable con el modelo de polinómico identificado.
% Obtenida mediante 'Polynomial Models' con na=2, nb=1, nk=0.
% El filtrado mejora considerablemente el modelo.
Opt = arxOptions;                         
ARX = arx(dataf,[2 1 0], Opt);
%-------------------------------------------------------

% FIGURAS
%-------------------------------------------------------
%% Figura 1: respuesta modelo 'Gs' superponiendo la respuesta del sistema.
%Figura 1.1: Modelo sin filtrar frente a modelo Gs
figure;
subplot(1,2,1);
plot(t,in,'--');
hold;
plot(t,out);
step(5*Gs);
xlim([1 200]);
title('Respuesta Gs y respuesta Sistema');
legend({'referencia','Sistema','Respuesta Gs'},'FontSize',8,'Location','southeast');

%Figura 1.2: Modelo filtrado frente a modelo Gs -> apreciar retardo
subplot(1,2,2); 
plot(t,in,'--');
hold;
plot(t,out_f);
step(5*Gs);
xlim([1 200]);
title('Respuesta Gs y respuesta Sistema filtrado');
legend({'referencia','Sistema filtrado','Respuesta Gs'},'FontSize',8,'Location','southeast');
%-------------------------------------------------------
% Eliminamos los labels por defecto de todas las figuras
axIm = findall(gcf,'String','Amplitude'); 
axRe = findall(gcf,'String','Time (seconds)');
% Definimos los labels deseados
set(axIm,'String','voltios (v)'); 
set(axRe,'String','tiempo (s)');
%-------------------------------------------------------
%% Figura 2: respuesta modelo 'Gz' superponiendo la respuesta del sistema
%Figura 2.1: Modelo sin filtrar frente a modelo Gz
figure;
subplot(1,2,1);
plot(t,in,'--');
hold;
plot(t,out);
step(5*Gz);
xlim([1 200]);
title('Respuesta Gz y respuesta Sistema');
legend({'referencia','Sistema','Respuesta Gz'},'FontSize',8,'Location','southeast');

%Figura 2.2: Modelo filtrado frente a modelo Gz -> apreciar retardo
subplot(1,2,2); 
plot(t,in,'--');
hold;
plot(t,out_f);
step(5*Gz);
xlim([1 200]);
title('Respuesta Gz y respuesta Sistema filtrado');
legend({'referencia','Sistema filtrado','Respuesta Gz'},'FontSize',8,'Location','southeast');
%-------------------------------------------------------
% Eliminamos los labels por defecto de todas las figuras
axIm = findall(gcf,'String','Amplitude'); 
axRe = findall(gcf,'String','Time (seconds)');
% Definimos los labels deseados
set(axIm,'String','voltios (v)'); 
set(axRe,'String','tiempo (s)');
%-------------------------------------------------------
%% Figura 3: respuesta modelo 'Proceso' superponiendo la respuesta del sistema 
%Figura 3.1: Modelo sin filtrar frente a modelo 'Proceso'
figure;
subplot(1,2,1);
plot(t,in,'--');
hold;
plot(t,out);
step(5*Proceso);
xlim([1 200]);
title('Respuesta Proceso y respuesta Sistema');
legend({'referencia','Sistema','Respuesta Proceso'},'FontSize',8,'Location','southeast');

%Figura 3.2: Modelo filtrado frente a modelo Proceso -> apreciar retardo
subplot(1,2,2); 
plot(t,in,'--');
hold;
plot(t,out_f);
step(5*Proceso);
xlim([1 200]);
title('Respuesta Proceso y respuesta Sistema filtrado');
legend({'referencia','Sistema filtrado','Respuesta Proceso'},'FontSize',8,'Location','southeast');
%-------------------------------------------------------
% Eliminamos los labels por defecto de todas las figuras
axIm = findall(gcf,'String','Amplitude'); 
axRe = findall(gcf,'String','Time (seconds)');
% Definimos los labels deseados
set(axIm,'String','voltios (v)'); 
set(axRe,'String','tiempo (s)');
%-------------------------------------------------------
%% Figura 4: respuesta del modelo ARX superponiendo la respuesta del sistema.
%Figura 4.1: Modelo sin filtrar frente a modelo ARX
figure;
subplot(1,2,1);
plot(t,in,'--');
hold;
plot(t,out);
step(5*ARX);
xlim([1 200]);
title('Respuesta ARX y respuesta Sistema');
legend({'referencia','Sistema','Respuesta ARX'},'FontSize',8,'Location','southeast');

%Figura 4.2: Modelo filtrado frente a modelo ARX -> apreciar retardo
subplot(1,2,2); 
plot(t,in,'--');
hold;
plot(t,out_f);
step(5*ARX);
xlim([1 200]);
title('Respuesta ARX y respuesta Sistema filtrado');
legend({'referencia','Sistema filtrado','Respuesta ARX'},'FontSize',8,'Location','southeast');
%-------------------------------------------------------
% Eliminamos los labels por defecto de todas las figuras
axIm = findall(gcf,'String','Amplitude'); 
axRe = findall(gcf,'String','Time (seconds)');
% Definimos los labels deseados
set(axIm,'String','voltios (v)'); 
set(axRe,'String','tiempo (s)');
%-------------------------------------------------------
end
