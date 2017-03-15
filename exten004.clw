

   MEMBER('extenso.clw')                                   ! This is a MEMBER module

                     MAP
                       INCLUDE('EXTEN004.INC'),ONCE        !Local module procedure declarations
                     END


ExtensoNova          PROCEDURE                             ! Declare Procedure
nomeExtenso String(150)
  CODE
    do extenso
extenso ROUTINE
 data
unidades STRING(10),DIM(10)
excecoes STRING(10),DIM(10)
dezenas  STRING(10),DIM(10)
centenas STRING(12),DIM(10)
ctvs    string(2) !centavos
numero  string(100)
posicao long
tamanho long
 code
     !      CARREGA VARIAVEIS
     unidades[0] = ''
     unidades[1] = 'um'
     unidades[2] = 'dois'
     unidades[3] = 'tres'
     unidades[4] = 'quatro'
     unidades[5] = 'cinco'
     unidades[6] = 'seis'
     unidades[7] = 'sete'
     unidades[8] = 'oito'
     unidades[9] = 'nove'
     !
     excecoes[0] = ''
     excecoes[1] = 'onze'
     excecoes[2] = 'doze'
     excecoes[3] = 'treze'
     excecoes[4] = 'quatorze'
     excecoes[5] = 'quinze'
     excecoes[6] = 'dezesseis'
     excecoes[7] = 'dezessete'
     excecoes[8] = 'dezoito'
     excecoes[9] = 'dezenove'
     !
     dezenas[0] = ''
     dezenas[1] = 'dez'
     dezenas[2] = 'vinte'
     dezenas[3] = 'trinta'
     dezenas[4] = 'quarenta'
     dezenas[5] = 'cinquenta'
     dezenas[6] = 'sessenta'
     dezenas[7] = 'setenta'
     dezenas[8] = 'oitenta'
     dezenas[9] = 'noventa'
     !
     centenas[0] = ''
     centenas[1] = 'cem'
     centenas[2] = 'duzentos'
     centenas[3] = 'trezentos'
     centenas[4] = 'quatrocentos'
     centenas[5] = 'quinhentos'
     centenas[6] = 'seiscentos'
     centenas[7] = 'setecentos'
     centenas[8] = 'oitocentos'
     centenas[9] = 'novecentos'
     !      REMOVE PONTUAÇÃO
     numero = num !num varivel global
     loop i# = 1 to len(clip(numero)) by 1
         posicao = instring('.', numero, 1, 1)
         if posicao <> 0 then numero[posicao] = '' end
     end
     !      PEGA OS CENTAVOS DEPOIS DA VIRGULA
     if not instring(',', numero, 1, 1) then numero = clip(numero)&',00' end !VERIFICA SE TEM ','
     posicao = instring(',', numero, 1, 1)
     ctvs = sub(numero, (posicao+1), 100)
     !      PEGA CASAS DECIMAIS ANTES DA VIRGULA
     numero = sub(numero, 1, (posicao-1))
     !      RETIRA OS ESPAÇOS DEIXADOS NO NUMERO
     aux# = ''
     loop j# = 1 to len(clip(numero)) by 1
         if numero[j#] <> '' then aux# = aux# & numero[j#] end
     end
     numero = aux#
     !
     tamanho = len(clip(numero))

     if tamanho >= 1 and tamanho < 4 
         centena# = len(clip(numero))
         if centena# = 1
             !  UNIDADE
             loop i# = 1 to 9 by 1
                 if numero[1] = i#
                     nomeExtenso = unidades[i#]
                     if numero[1] = 1
                         nomeExtenso = clip(nomeExtenso) & ' real'
                     else
                         nomeExtenso = clip(nomeExtenso) & ' reais'
                     end
                     break
                 end
             end
         elsif centena# = 2
             ! DEZENAS
             if numero[1] = 1 and numero[2] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[1] = i#
                         nomeExtenso = dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             nomeExtenso = clip(nomeExtenso) & ' reais'
         else
             ! CENTENA
             loop i# = 1 to 9 by 1
                 if numero[1] = i#
                    if numero[1] = 1 and numero[2] = 0 and numero[3] = 0
                        nomeExtenso = 'cem'
                    elsif numero[1] = 1
                        nomeExtenso = 'cento'
                    else
                        nomeExtenso = centenas[i#]
                    end
                    break
                 end
             end

             ! DEZENAS
             if numero[2] = 1 and numero[3] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[3] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[3] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             if numero[1] <> 0 or numero[2] <> 0 or numero[3] <> 0
                 if numero[1] = 0 and numero[2] = 0 and numero[3] = 1
                     nomeExtenso = clip(nomeExtenso) & ' real'
                 else
                     nomeExtenso = clip(nomeExtenso) & ' reais'
                 end
             end
         end
     elsif tamanho > 3 and tamanho < 7 !MILHAR
         milhar# = len(clip(numero))
         if milhar# = 6
             ! CENTENA
             loop i# = 1 to 9 by 1
                 if numero[1] = i#
                    if numero[1] = 1 and numero[2] = 0 and numero[3] = 0
                        nomeExtenso = 'cem'
                    elsif numero[1] = 1
                        nomeExtenso = 'cento'
                    else
                        nomeExtenso = centenas[i#]
                    end
                    break
                 end
             end

             ! DEZENAS
             if numero[2] = 1 and numero[3] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[3] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[3] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             nomeExtenso = clip(nomeExtenso) & ' mil'

             ! CENTENA
             loop i# = 1 to 9 by 1
                 if numero[4] = i#
                    if numero[4] = 1 and numero[5] = 0 and numero[6] = 0
                        nomeExtenso = clip(nomeExtenso) & ' e cem'
                    elsif numero[4] = 1
                        nomeExtenso = clip(nomeExtenso) & ' e cento'
                    else
                        nomeExtenso = clip(nomeExtenso) & ' e ' & centenas[i#]
                    end
                    break
                 end
             end

             ! DEZENAS
             if numero[5] = 1 and numero[6] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[6] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[5] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[6] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             if numero[4] <> 0 or numero[5] <> 0 or numero[6] <> 0
                 if numero[4] = 0 and numero[5] = 0 and numero[6] = 1
                     nomeExtenso = clip(nomeExtenso) & ' real'
                 else
                     nomeExtenso = clip(nomeExtenso) & ' reais'
                 end
             end
         elsif milhar# = 5
             ! DEZENAS
             if numero[1] = 1 and numero[2] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[1] = i#
                         nomeExtenso = dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[2] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             nomeExtenso = clip(nomeExtenso) & ' mil'

             ! CENTENA
             loop i# = 1 to 9 by 1
                if numero[3] = i#
                    if numero[3] = 1 and numero[4] = 0 and numero[5] = 0
                        nomeExtenso = clip(nomeExtenso) & ' e cem'
                    elsif numero[3] = 1
                        nomeExtenso = clip(nomeExtenso) & ' e cento'
                    else
                        nomeExtenso = clip(nomeExtenso) & ' e ' & centenas[i#]
                    end
                    break
                end
             end

             ! DEZENAS
             if numero[4] = 1 and numero[5] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[5] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[4] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[5] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             if numero[3] <> 0 or numero[4] <> 0 or numero[5] <> 0
                 if numero[3] = 0 and numero[4] = 0 and numero[5] = 1
                     nomeExtenso = clip(nomeExtenso) & ' real'
                 else
                     nomeExtenso = clip(nomeExtenso) & ' reais'
                 end
             end
         else !milhar# = 4
             !  UNIDADE
             loop i# = 1 to 9 by 1
                 if numero[1] = i#
                     nomeExtenso = unidades[i#]
                     break
                 end
             end
             nomeExtenso = clip(nomeExtenso) & ' mil'

             ! CENTENA
             loop i# = 1 to 9 by 1
                if numero[2] = i#
                    if numero[2] = 1 and numero[3] = 0 and numero[4] = 0
                        nomeExtenso = clip(nomeExtenso) & ' e cem'
                    elsif numero[2] = 1
                        nomeExtenso = clip(nomeExtenso) & ' e cento'
                    else
                        nomeExtenso = clip(nomeExtenso) & ' e ' & centenas[i#]
                    end
                    break
                end
             end

             ! DEZENAS
             if numero[3] = 1 and numero[4] <> 0
                 ! EXCECOES
                 loop i# = 1 to 9 by 1
                     if numero[4] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                         break
                     end
                 end
             else
                 loop i# = 1 to 9 by 1
                     if numero[3] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                         break
                     end
                 end

                 loop i# = 1 to 9 by 1
                     if numero[4] = i#
                         nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                         break
                     end
                 end
             end
             if numero[2] <> 1 or numero[3] <> 0 or numero[4] <> 0
                 if numero[2] = 0 and numero[3] = 0 and numero[4] = 1
                     nomeExtenso = clip(nomeExtenso) & ' real'
                 else
                     nomeExtenso = clip(nomeExtenso) & ' reais'
                 end
             end
             
         end
     else ! numero = 7 !MILHAO

         !  UNIDADE
         loop i# = 1 to 9 by 1
             if numero[1] = i#
                 nomeExtenso = unidades[i#]
                 break
             end
         end
         nomeExtenso = clip(nomeExtenso) & ' milhão'

         ! CENTENA
         loop i# = 1 to 9 by 1
            if numero[2] = i#
                if numero[2] = 1 and numero[3] = 0 and numero[4] = 0
                    nomeExtenso = clip(nomeExtenso) & ' e cem'
                elsif numero[2] = 1
                    nomeExtenso = clip(nomeExtenso) & ' e cento'
                else
                    nomeExtenso = clip(nomeExtenso) & ' e ' & centenas[i#]
                end
                break
            end
         end

         ! DEZENAS
         if numero[3] = 1 and numero[4] <> 0
             ! EXCECOES
             loop i# = 1 to 9 by 1
                 if numero[4] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                     break
                 end
             end
         else
             loop i# = 1 to 9 by 1
                 if numero[3] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                     break
                 end
             end

             loop i# = 1 to 9 by 1
                 if numero[4] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                     break
                 end
             end
         end
         if numero[2] <> 0 or numero[3] <> 0 or numero[4] <> 0
             nomeExtenso = clip(nomeExtenso) & ' mil'
         end

         ! CENTENA
         loop i# = 1 to 9 by 1
             if numero[5] = i#
                if numero[5] = 1 and numero[6] = 0 and numero[7] = 0
                    nomeExtenso = clip(nomeExtenso) & ' e cem'
                elsif numero[5] = 1
                    nomeExtenso = clip(nomeExtenso) & ' e cento'
                else
                    nomeExtenso = clip(nomeExtenso) & ' e ' & centenas[i#]
                end
                break
             end
         end

         ! DEZENAS
         if numero[6] = 1 and numero[7] <> 0
             ! EXCECOES
             loop i# = 1 to 9 by 1
                 if numero[7] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                     break
                 end
             end
         else
             loop i# = 1 to 9 by 1
                 if numero[6] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                     break
                 end
             end

             loop i# = 1 to 9 by 1
                 if numero[7] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                     break
                 end
             end
         end
         if numero[5] <> 0 or numero[6] <> 0 or numero[7] <> 0
             if numero[5] = 0 and numero[6] = 0 and numero[7] = 1
                 nomeExtenso = clip(nomeExtenso) & ' real'
             else
                 nomeExtenso = clip(nomeExtenso) & ' reais'
             end
         end
     end

     
     if ctvs[1] <> 0 or ctvs[2] <> 0
         ! CENTAVOS
         if ctvs[1] = 1 and ctvs[2] <> 0
             ! EXCECOES
             loop i# = 1 to 9 by 1
                 if ctvs[2] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & excecoes[i#]
                     break
                 end
             end
         else
             loop i# = 1 to 9 by 1
                 if ctvs[1] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & dezenas[i#]
                     break
                 end
             end

             loop i# = 1 to 9 by 1
                 if ctvs[2] = i#
                     nomeExtenso = clip(nomeExtenso) & ' e ' & unidades[i#]
                     break
                 end
             end
         end
         if ctvs[1] = 0 and ctvs[2] = 1
             nomeExtenso = clip(nomeExtenso) & ' centavo'
         else
             nomeExtenso = clip(nomeExtenso) & ' centavos'
         end
     end
     
     message(nomeExtenso)
 exit
