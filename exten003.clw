

   MEMBER('extenso.clw')                                   ! This is a MEMBER module

                     MAP
                       INCLUDE('EXTEN003.INC'),ONCE        !Local module procedure declarations
                     END


Extenso              PROCEDURE                             ! Declare Procedure
!VARIAVEIS DA ROTINA ext
centena byte
dezena  byte
unidade byte
resultExt string(100)

!VARIAVEIS DE TESTE
valor decimal(20,2,0)
  CODE
    !
    valor = 1.45

    do extenso
    !
extenso ROUTINE
 DATA
M  group, pre() !MOEDAS
moeda       string('real')
moedas      string('reais')
deMoedas    string('de reais')
        end

numero  string(@N_18.2)
e           string(2)
x           string(50),dim(6)
y           group,over(x),pre()
z           string(1)
t           string(299)
        end

nx  group,over(numero),pre()
n4      string(@n_3)
n3      string(@n_3)
n2      string(@n_3)
n1      string(@n_3)
n0      string(@n_3)
ct      string(@n_3)
    end
 CODE
     if valor = 0 then message('zero ' & moedas) end
     clear(x,0)
     numero = valor
     if ct > 0 !centavos
         e=' e'
         if ct=1
             x[1]=' um centavo'
             if n4+n3+n2+n1+n0 = 0 then message('um centavo de ' & moeda) end
         else
             centena = '0'
             dezena  = ct[2]
             unidade = ct[3]
             do ext !chama a rotina ext que peenche a variavel resultExt
             x[1] = clip(resultExt) & ' centavos'
             if n4+n3+n2+n1+n0 = 0
                 centena = ct[1]
                 dezena  = ct[2]
                 unidade = ct[3]
                 do ext !chama a rotina ext que peenche a variavel resultExt
                 x[1] = clip(resultExt) & ' centavos de ' & moedas
             end
         end
     end

     if n0 > 0 !unidades
         if n0 =1 then x[2] = ' um ' & moeda & e end
     else
         centena = n0[1]
         dezena  = n0[2]
         unidade = n0[3]
         do ext !chama a rotina ext que peenche a variavel resultExt
         x[2] = clip(resultExt) & ' ' & moedas & e
     end
     !e ou virgula
     clear(m,0) !limpa o nome da moeda
     if e = ' e' then e = ', ' end
     if e = '' then e =' e' end

     message(t)
 EXIT

ext ROUTINE
 DATA
Uniw    byte(6)
Undw    byte(9)
Dezw    byte(9)
Cenw    byte(12)
Uni    string('hum  dois três  quatro   cinco seis  sete  oito  nove')
Und    string('dez onze doze treze quatorze quinze dezesseis dezessete dezoito dezenove')
Dez    string('vinte   trinta    quarenta cinquentasessenta setenta oitenta noventa ')
Cen    string('cento duzentos trezentos quatrocetos quinhentos seiscentos setecentos oitocentos novecentos')
 CODE
     !
     if centena = 1 and (dezena + unidade) = 0 then
         resultExt = ' cem'
         
     end
     !
     resultExt=''
     if centena > 0 then resultExt = ' ' & clip(sub(cen,(centena-1)*cenw+1,cenw)) end
     !
     if (dezena + unidade) = 0 then
         
     end
     !
     if centena > 0 then resultExt = clip(resultExt) & ' e' end
     !
     if dezena = 0 then
         resultExt = clip(resultExt) & ' ' & sub(uni,(unidade-1)*uniw+1,Uniw)
         
     end
     !
     if dezena = 1 then
         resultExt = clip(resultExt) & ' ' & sub(Und,unidade*undw+1,undw)
         
     end
     !
     resultExt= clip(resultExt) & ' ' &  sub(dez, (dezena-2)*dezw+1, dezw)
     if unidade = 0 then

     end
     !
     resultExt = clip(resultExt) & ' e ' & sub(uni, (unidade-1)*uniw+1,uniw)
 EXIT
