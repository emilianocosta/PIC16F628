; _______ .___  ___.  __   __       __       ___      .__   __.   ______   
;|   ____||   \/   | |  | |  |     |  |     /   \     |  \ |  |  /  __  \  
;|  |__   |  \  /  | |  | |  |     |  |    /  ^  \    |   \|  | |  |  |  | 
;|   __|  |  |\/|  | |  | |  |     |  |   /  /_\  \   |  . `  | |  |  |  | 
;|  |____ |  |  |  | |  | |  `----.|  |  /  _____  \  |  |\   | |  `--'  |
;|_______||__|  |__| |__| |_______||__| /__/     \__\ |__| \__|  \______/
;										  ..........___. 
; 										  ........((((....\
; 										  .........)u.\....)
; 										  .........\_..\...(
; 										  .........._)..\...)
; 										  ./\.__/..'-'/.\.(
; 										  .\.|__(___/..|
;										  ..\|.............|. 
;  									  ...|............/
;										  ....\__...--'\
;									  .....|...........\
;									  .....|...........|
;									  .....|............\__
;									  .....|..................\-.
;									  .....\__________\_`-,
;========|=========|=========|=========|=========|=========|=========|=========|
;= Disciplina: 	Microcontroladores
;= Professor: 		Marcos Zamboni                                              
;= Aluno:   		Emiliano Costa Junior 
;= RA:				1260901923008
;= MCU: 				PIC16F628
;= VERSÃO:			1.0 
;= DATA:				10/agosto/2021
;= Revisão			02/Setembro/2021
;========|=========|=========|=========|=========|=========|=========|=========|

;________                             .__                      
;\______ \   ____   ______ ___________|__| ____ _____    ____  
; |    |  \_/ __ \ /  ___// ___\_  __ \  |/ ___\\__  \  /  _ \ 
; |    `   \  ___/ \___ \\  \___|  | \/  \  \___ / __ \(  <_> )
;/_______  /\___  >____  >\___  >__|  |__|\___  >____  /\____/ 
;        \/     \/     \/     \/              \/     \/      
;______________________________________________________________________________|
; 	*Liga um LED na porta RB0
;========|=========|=========|=========|=========|=========|=========|=========|
;________          _____.__       .__                            
;\______ \   _____/ ____\__| ____ |__| ____  ____   ____   ______
; |    |  \_/ __ \   __\|  |/    \|  |/ ___\/  _ \_/ __ \ /  ___/
; |    `   \  ___/|  |  |  |   |  \  \  \__(  <_> )  ___/ \___ \ 
;/_______  /\___  >__|  |__|___|  /__|\___  >____/ \___  >____  >
;        \/     \/              \/        \/           \/     \/
;______________________________________________________________________________|
;=(INFORMAÇÕES RELATIVAS AO PIC) 
#INCLUDE <P16F628A.INC>		;ARQUIVO PADRÃO MICROCHIP PARA 16F628A
	__CONFIG  _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _INTOSC_OSC_NOCLKOUT
;_BODEN	 	//Tensão abaixo de 4V reseta o microcontolador, só ativar quando for haver comunicação serial (RS232,etc...)
;_CP		//codigo de proteção - protege o microcolador contra pirataria.  
;			//__IDLOCS	0X6363 - onde (6363) é o código de proteção que será informado.
;_PWRTE		//se (ON) espera 72ms para startar o microcontrolador garantido que a fonte se estebilize.
;			//se precisar pode aumentar o tempo acoplando um circuito RC no pino de [master clear]
;_WDT		//watch dog time - quando (ON) conta um determinado tempo se o programa para o WDT estoura e o programa reseta
;			//tomar cuidado quando fazer revisão do programa,
;			//sempre primeiro fazer o programa sem WDT, só depois de consolidado podemos ativar.
;			//usar o stopwhatch para fazer a contagem de linhas.
;_LVP		//LOW VOLTAGE PROGRAM - programação por baixa tensão, reprograma a memória flash, nunca usar com inversor de frequencia ou motores. 
;			//PGM pino [10] reserva o pino [RB4] para gravação 
;_MCLRE		//ativa pino_4[RA5] como master clear externo 
;_INTOSC_OSC_NOCLKOUT 			tipo de oscilador; no caso interno sem clock de saída.
;_INTOSC_OSC_CLKOUT 				tipo de oscilador; no caso interno com clock de saída, elimina [RA7].
;========|=========|=========|=========|=========|=========|=========|=========|
;   _____                              .__        
;  /     \   ____   _____   ___________|__|____   
; /  \ /  \_/ __ \ /     \ /  _ \_  __ \  \__  \  
;/    Y    \  ___/|  Y Y  (  <_> )  | \/  |/ __ \_
;\____|__  /\___  >__|_|  /\____/|__|  |__(____  /
;        \/     \/      \/                     \/ 
;______________________________________________________________________________|
;(DEFINIÇÕES  0DO BANCO DE MEMÓRIA)                      							     
;DEFINIÇÃO DE COMANDOS PARA FACILITAR ALTERAÇÃO DA PÁGINA DE MEMÓRIA                            
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA [ BCF STATUS,5]
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MEMÓRIA [ BSF STATUS,5]
;========|=========|=========|=========|=========|=========|=========|=========|
;____   ____            .__                   .__        
;\   \ /   /____ _______|__|____ ___  __ ____ |__| ______
; \   Y   /\__  \\_  __ \  \__  \\  \/ // __ \|  |/  ___/
;  \     /  / __ \|  | \/  |/ __ \\   /\  ___/|  |\___ \ 
;   \___/  (____  /__|  |__(____  /\_/  \___  >__/____  >
;               \/              \/          \/        \/
;______________________________________________________________________________|
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS  PELO SISTEMA
	CBLOCK	0x20		;ENDEREÇO INICIAL DA MEMÓRIA DO USUÁRIO
		W_TEMP			;REGISTRADORES TEMPORÁRIOS PARA USO JUNTO ÀS INTERRUPÇÕES
		STATUS_TEMP		;ESTAS VARIÁVEIS NÃO SERÃO UTILIZADAS  NESTE PROGRAMA
		TEMP1
		TEMP2
		TEMP3
	ENDC				;FIM DO BLOCO DE MEMÓRIA
;========|=========|=========|=========|=========|=========|=========|=========|
;___________.__                        
;\_   _____/|  | _____     ____  ______
; |    __)  |  | \__  \   / ___\/  ___/
; |     \   |  |__/ __ \_/ /_/  >___ \ 
; \___  /   |____(____  /\___  /____  >
;     \/              \//_____/     \/
;______________________________________________________________________________|
;DEFINIÇÃO DE TODOS OS FLAGS(BITS USADOS COMO CHAVES) UTILIZADOS PELO SISTEMA

;========|=========|=========|=========|=========|=========|=========|=========|
;\_   ___ \  ____   ____   _______/  |______    _____/  |_  ____   ______
;/    \  \/ /  _ \ /    \ /  ___/\   __\__  \  /    \   __\/ __ \ /  ___/
;\     \___(  <_> )   |  \\___ \  |  |  / __ \|   |  \  | \  ___/ \___ \ 
; \______  /\____/|___|  /____  > |__| (____  /___|  /__|  \___  >____  >
;        \/            \/     \/            \/     \/          \/     \/ 
;______________________________________________________________________________|
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA (EQU.)
; VINTE   EQU .20
;========|=========|=========|=========|=========|=========|=========|=========|
;___________       __                     .___              
;\_   _____/ _____/  |_____________     __| _/____    ______
; |    __)_ /    \   __\_  __ \__  \   / __ |\__  \  /  ___/
; |        \   |  \  |  |  | \// __ \_/ /_/ | / __ \_\___ \ 
;/_______  /___|  /__|  |__|  (____  /\____ |(____  /____  >
;        \/     \/                 \/      \/     \/     \/ 
;______________________________________________________________________________|
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)
;#DEFINE	BOT1	PORTA,0			;PORTA DO BOTÃO 1
;#DEFINE	BOT2	PORTA,3			;PORTA DO BOTÃO 2			
										; 0 -> PRESSIONADO
										; 1 -> LIBERADO
;========|=========|=========|=========|=========|=========|=========|=========|
; _________      .__    .___              
; /   _____/____  |__| __| / ____    ______
; \_____  \\__  \ |  |/ __ |\__  \  /  ___/
; /        \/ __ \|  / /_/ | / __ \_\___ \ 
;/_______  (____  /__\____ |(____  /____  >
;        \/     \/        \/     \/     \/
;______________________________________________________________________________|
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)
#DEFINE  LED1   PORTB,0
;#DEFINE  LED2   PORTB,3	        
;#DEFINE  VENTILADOR   PORTB,7   ; LIGA O VENTILADOR EM NIVEL LOGICO 1  
;========|=========|=========|=========|=========|=========|=========|=========|
;__________                      __   
;\______   \ ____   ______ _____/  |_ 
; |       _// __ \ /  ___// __ \   __\
; |    |   \  ___/ \___ \\  ___/|  |  
; |____|_  /\___  >____  >\___  >__|  
;        \/     \/     \/     \/      
;______________________________________________________________________________|
	ORG	0x00 ;ENDEREÇO INICIAL DE PROCESSAMENTO (OXOO PARA O 16F628A)<<PERGUNTA DE PROVA 
	GOTO	INICIO
;========|=========|=========|=========|=========|=========|=========|=========|
;.___        __                                                         
;|   | _____/  |_  __________________ __ ________   ____ _____    ____  
;|   |/    \   __\/ __ \_  __ \_  __ \  |  \____ \_/ ___\\__  \  /  _ \ 
;|   |   |  \  | \  ___/|  | \/|  | \/  |  /  |_> >  \___ / __ \(  <_> )
;|___|___|  /__|  \___  >__|   |__|  |____/|   __/ \___  >____  /\____/ 
;         \/          \/                   |__|        \/     \/     
;______________________________________________________________________________|
; INICIO DA INTERRUPÇÃO	(OXO4 PARA O 16F628A)	
; ESTE SISTEMA NÃO É OBRIGATÓRIO, MAS PODE EVITAR PROBLEMAS FUTUROS.
; AS INTERRUPÇÕES NÃO SERÃO UTILIZADAS, POR ISSO PODEMOS SUBSTITUIR TODO O SISTEMA EXISTENTE NO
; ARQUIVO MODELO POR UM MAIS SIMPLES. PARA TANTO, APAGAR AS LINHAS ENTRE "ORG  0x04" E "RETFIE"
	
	ORG	0x04						;ENDEREÇO DE DESVIO DAS INTERRUPÇÕES OU ENDEREÇO INICIAL DA INTERRUPÇÃO
	MOVWF	W_TEMP					;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP				;COPIA STATUS PARA STATUS_TEMP

;==============================================================================|
;=                            ROTINA DE INTERRUPÇÃO                                     
;------------------------------------------------------------------------------|
;AQUI SERÃO ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS INTERRUPÇÕES

;==============================================================================|
;=                            ROTINA DE SAÍDA DA INTERRUPÇÃO                               
;------------------------------------------------------------------------------|
;OS VALORES DE "W" E "STATUS" 
; DEVEM SER RECUPERADOS ANTES DE RETORNAR DA INTERRUPÇÃO

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS					;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W					;MOVE W_TEMP PARA W
	RETFIE							;RETORNA DA INTERRUPÇÃO

;========|=========|=========|=========|=========|=========|=========|=========|
;__________        __  .__                      
;\______   \ _____/  |_|__| ____ _____    ______
; |       _//  _ \   __\  |/    \\__  \  /  ___/
; |    |   (  <_> )  | |  |   |  \/ __ \_\___ \ 
; |____|_  /\____/|__| |__|___|  (____  /____  >
;        \/                    \/     \/     \/ 
;______________________________________________________________________________|
; CADA ROTINA OU SUB-ROTINA DEVE TER: 
;	A DESCRIÇÃO DE FUNCIONAMENTO 
;	E UM NOME COERENTE À SUA FUNÇÃO



;========|=========|=========|=========|=========|=========|=========|=========|
;.___       .__       .__       .__  .__                                     
;|   | ____ |__| ____ |__|____  |  | |__|____________    ____ _____    ____  
;|   |/    \|  |/ ___\|  \__  \ |  | |  \___   /\__  \ _/ ___\\__  \  /  _ \ 
;|   |   |  \  \  \___|  |/ __ \|  |_|  |/    /  / __ \\  \___ / __ \(  <_> )
;|___|___|  /__|\___  >__(____  /____/__/_____ \(____  /\___  >____  /\____/ 
;         \/        \/        \/              \/     \/     \/     \/        
;______________________________________________________________________________|
INICIO
	BANK1					;ALTERA PARA O BANCO 1
	MOVLW B'11111111' 		; = BINARIO
;	MOVLW	.255 			; = DECIMAL     
;	MOVLW	0XFF 			; = HEXA   	
;	MOVLW	0377 			; = OCTAL
	MOVWF	TRISA			;DEFINE PORTA COMO ENTRADAS
	MOVLW	B'00000000'  	; 1=INPUT    0 =OUTPUT
	MOVWF	TRISB			;DEFINE PORTB COMO SAÍDAS
	MOVLW	B'10000100'		;Zero no bit, habilita pull-ups no PortB
	MOVWF	OPTION_REG		;DEFINE OPÇÕES DE OPERAÇÃO PRESCALER 1:2 NO TMR0
							;BIT 7 EM ZERO PULL-UPS HABILITADOS PARA OS PINOS DE ENTRADA DO PORTB
							;AS DEMAIS CONFG. SÃO IRRELEVANTES
	MOVLW	B'00000000'
	MOVWF	INTCON			;DEFINE OPÇÕES DE INTERRUPÇÕES DESLIGADAS

	BANK0					;RETORNA PARA O BANCO 0   BCF  STATUS,RP0
	MOVLW	B'00000111' 	;0x07   .7 >> Desliga comparadores analógicos
							;	>> Em caso de dúvida - pesquisar datashets
	MOVWF	CMCON			;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO, 
							;se não for usar desligar ponde (7) em [CMCON] 

;========|=========|=========|=========|=========|=========|=========|=========|
;____   ____            .__                   .__        
;\   \ /   /____ _______|__|____ ___  __ ____ |__| ______
; \   Y   /\__  \\_  __ \  \__  \\  \/ // __ \|  |/  ___/
;  \     /  / __ \|  | \/  |/ __ \\   /\  ___/|  |\___ \ 
;   \___/  (____  /__|  |__(____  /\_/  \___  >__/____  >
;               \/              \/          \/        \/
;______________________________________________________________________________|
;INICIALIZAÇÃO DAS VARIÁVEIS
	CLRF	PORTA						;LIMPA O PORT A
	CLRF	PORTB						;LIMPA O PORT B
;========|=========|=========|=========|=========|=========|=========|=========|
;   _____         .__        
;  /     \ _____  |__| ____  
; /  \ /  \\__  \ |  |/    \ 
;/    Y    \/ __ \|  |   |  \
;\____|__  (____  /__|___|  /
;        \/     \/        \/ 
;______________________________________________________________________________|
;IDENTIFICAÇÃO  DA VESÃO DO SEU PROJETO.
		__IDLOCS 0X6363 ;  
;______________________________________________________________________________|
;ROTINA PRINCIPAL
MAIN
   BSF  LED1
    
;______________________________________________________________________________|
;FIM DO PROGRAMA
	END  ;OBRIGATÓRIO