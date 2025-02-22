; _______ .___  ___.  __   __       __       ___      .__   __.   ______   
;|   ____||   \/   | |  | |  |     |  |     /   \     |  \ |  |  /  __  \  
;|  |__   |  \  /  | |  | |  |     |  |    /  ^  \    |   \|  | |  |  |  | 
;|   __|  |  |\/|  | |  | |  |     |  |   /  /_\  \   |  . `  | |  |  |  | 
;|  |____ |  |  |  | |  | |  `----.|  |  /  _____  \  |  |\   | |  `--'  |
;|_______||__|  |__| |__| |_______||__| /__/     \__\ |__| \__|  \______/
;..........___. 
;........((((....\
;.........)u.\....)
;.........\_..\...(
;.........._)..\...)
;./\.__/..'-'/.\.(
;.\.|__(___/..|
;..\|.............|. 
;...|............/
;....\__...--'\
;.....|...........\
;.....|...........|
;.....|............\__
;.....|..................\-.
;.....\__________\_`-,
;========|=========|=========|=========|=========|=========|=========|=========|
;= Disciplina: 	Microcontroladores
;= Professor: 		Marcos Zamboni                                              
;= Aluno:   		Emiliano Costa Junior 
;= RA:				1260901923008
;= MCU: 				PIC16F628
;= VERS�O:			1.0 
;= DATA:				24/agosto/2021
;= Revis�o			02/Setembro/2021
;========|=========|=========|=========|=========|=========|=========|=========|

;________                             .__                      
;\______ \   ____   ______ ___________|__| ____ _____    ____  
; |    |  \_/ __ \ /  ___// ___\_  __ \  |/ ___\\__  \  /  _ \ 
; |    `   \  ___/ \___ \\  \___|  | \/  \  \___ / __ \(  <_> )
;/_______  /\___  >____  >\___  >__|  |__|\___  >____  /\____/ 
;        \/     \/     \/     \/              \/     \/      
;______________________________________________________________________________|
; 	*Rotaciona o LED ligado entre os seis conectados
;========|=========|=========|=========|=========|=========|=========|=========|
;________          _____.__       .__                            
;\______ \   _____/ ____\__| ____ |__| ____  ____   ____   ______
; |    |  \_/ __ \   __\|  |/    \|  |/ ___\/  _ \_/ __ \ /  ___/
; |    `   \  ___/|  |  |  |   |  \  \  \__(  <_> )  ___/ \___ \ 
;/_______  /\___  >__|  |__|___|  /__|\___  >____/ \___  >____  >
;        \/     \/              \/        \/           \/     \/
;______________________________________________________________________________|
;=(INFORMA��ES RELATIVAS AO PIC) 
#INCLUDE <P16F628A.INC>		;ARQUIVO PADR�O MICROCHIP PARA 16F628A
	__CONFIG  _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _INTOSC_OSC_NOCLKOUT
;========|=========|=========|=========|=========|=========|=========|=========|
;   _____                              .__        
;  /     \   ____   _____   ___________|__|____   
; /  \ /  \_/ __ \ /     \ /  _ \_  __ \  \__  \  
;/    Y    \  ___/|  Y Y  (  <_> )  | \/  |/ __ \_
;\____|__  /\___  >__|_|  /\____/|__|  |__(____  /
;        \/     \/      \/                     \/ 
;______________________________________________________________________________|
;(DEFINI��ES  0DO BANCO DE MEM�RIA)                      							     
;DEFINI��O DE COMANDOS PARA FACILITAR ALTERA��O DA P�GINA DE MEM�RIA                            
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA [ BCF STATUS,5]
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MEM�RIA [ BSF STATUS,5]
;========|=========|=========|=========|=========|=========|=========|=========|
;____   ____            .__                   .__        
;\   \ /   /____ _______|__|____ ___  __ ____ |__| ______
; \   Y   /\__  \\_  __ \  \__  \\  \/ // __ \|  |/  ___/
;  \     /  / __ \|  | \/  |/ __ \\   /\  ___/|  |\___ \ 
;   \___/  (____  /__|  |__(____  /\_/  \___  >__/____  >
;               \/              \/          \/        \/
;______________________________________________________________________________|
; DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS  PELO SISTEMA
	CBLOCK	0x20		;ENDERE�O INICIAL DA MEM�RIA DO USU�RIO
		W_TEMP			;REGISTRADORES TEMPOR�RIOS PARA USO JUNTO �S INTERRUP��ES
		STATUS_TEMP		;ESTAS VARI�VEIS N�O SER�O UTILIZADAS  NESTE PROGRAMA
		TEMP1
		TEMP2
		TEMP3
	ENDC				;FIM DO BLOCO DE MEM�RIA
;========|=========|=========|=========|=========|=========|=========|=========|
;___________.__                        
;\_   _____/|  | _____     ____  ______
; |    __)  |  | \__  \   / ___\/  ___/
; |     \   |  |__/ __ \_/ /_/  >___ \ 
; \___  /   |____(____  /\___  /____  >
;     \/              \//_____/     \/
;______________________________________________________________________________|
;DEFINI��O DE TODOS OS FLAGS(BITS USADOS COMO CHAVES) UTILIZADOS PELO SISTEMA

;========|=========|=========|=========|=========|=========|=========|=========|
;\_   ___ \  ____   ____   _______/  |______    _____/  |_  ____   ______
;/    \  \/ /  _ \ /    \ /  ___/\   __\__  \  /    \   __\/ __ \ /  ___/
;\     \___(  <_> )   |  \\___ \  |  |  / __ \|   |  \  | \  ___/ \___ \ 
; \______  /\____/|___|  /____  > |__| (____  /___|  /__|  \___  >____  >
;        \/            \/     \/            \/     \/          \/     \/ 
;______________________________________________________________________________|
; DEFINI��O DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA (EQU.)
; VINTE   EQU .20
;========|=========|=========|=========|=========|=========|=========|=========|
;___________       __                     .___              
;\_   _____/ _____/  |_____________     __| _/____    ______
; |    __)_ /    \   __\_  __ \__  \   / __ |\__  \  /  ___/
; |        \   |  \  |  |  | \// __ \_/ /_/ | / __ \_\___ \ 
;/_______  /___|  /__|  |__|  (____  /\____ |(____  /____  >
;        \/     \/                 \/      \/     \/     \/ 
;______________________________________________________________________________|
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)
#DEFINE	BOT	PORTA,0			;PORTA DO BOT�O 1
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
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO SA�DA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)
#DEFINE  LED0   PORTB,0
#DEFINE  LED1   PORTB,1
#DEFINE  LED2   PORTB,2
#DEFINE  LED3   PORTB,3
#DEFINE  LED4   PORTB,4
#DEFINE  LED5   PORTB,5
#DEFINE  LED6   PORTB,6
#DEFINE  LED7   PORTB,7

;========|=========|=========|=========|=========|=========|=========|=========|
;__________                      __   
;\______   \ ____   ______ _____/  |_ 
; |       _// __ \ /  ___// __ \   __\
; |    |   \  ___/ \___ \\  ___/|  |  
; |____|_  /\___  >____  >\___  >__|  
;        \/     \/     \/     \/      
;______________________________________________________________________________|
	ORG	0x00 ;ENDERE�O INICIAL DE PROCESSAMENTO (OXOO PARA O 16F628A)<<PERGUNTA DE PROVA 
	GOTO	INICIO
;========|=========|=========|=========|=========|=========|=========|=========|
;.___        __                                                         
;|   | _____/  |_  __________________ __ ________   ____ _____    ____  
;|   |/    \   __\/ __ \_  __ \_  __ \  |  \____ \_/ ___\\__  \  /  _ \ 
;|   |   |  \  | \  ___/|  | \/|  | \/  |  /  |_> >  \___ / __ \(  <_> )
;|___|___|  /__|  \___  >__|   |__|  |____/|   __/ \___  >____  /\____/ 
;         \/          \/                   |__|        \/     \/     
;______________________________________________________________________________|
; INICIO DA INTERRUP��O	(OXO4 PARA O 16F628A)	
; ESTE SISTEMA N�O � OBRIGAT�RIO, MAS PODE EVITAR PROBLEMAS FUTUROS.
; AS INTERRUP��ES N�O SER�O UTILIZADAS, POR ISSO PODEMOS SUBSTITUIR TODO O SISTEMA EXISTENTE NO
; ARQUIVO MODELO POR UM MAIS SIMPLES. PARA TANTO, APAGAR AS LINHAS ENTRE "ORG  0x04" E "RETFIE"
	
	ORG	0x04						;ENDERE�O DE DESVIO DAS INTERRUP��ES OU ENDERE�O INICIAL DA INTERRUP��O
	MOVWF	W_TEMP					;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP				;COPIA STATUS PARA STATUS_TEMP

;==============================================================================|
;=                            ROTINA DE INTERRUP��O                                     
;------------------------------------------------------------------------------|
;AQUI SER�O ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS INTERRUP��ES

;==============================================================================|
;=                            ROTINA DE SA�DA DA INTERRUP��O                               
;------------------------------------------------------------------------------|
;OS VALORES DE "W" E "STATUS" 
; DEVEM SER RECUPERADOS ANTES DE RETORNAR DA INTERRUP��O

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS					;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W					;MOVE W_TEMP PARA W
	RETFIE							;RETORNA DA INTERRUP��O

;========|=========|=========|=========|=========|=========|=========|=========|
;__________        __  .__                      
;\______   \ _____/  |_|__| ____ _____    ______
; |       _//  _ \   __\  |/    \\__  \  /  ___/
; |    |   (  <_> )  | |  |   |  \/ __ \_\___ \ 
; |____|_  /\____/|__| |__|___|  (____  /____  >
;        \/                    \/     \/     \/ 
;______________________________________________________________________________|
; CADA ROTINA OU SUB-ROTINA DEVE TER: 
;	A DESCRI��O DE FUNCIONAMENTO 
;	E UM NOME COERENTE � SUA FUN��O



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
;..............................................................................
	MOVLW B'11111111' 		; = BINARIO ;MOVLW	.255 = DECIMAL;	MOVLW	0XFF = HEXA; MOVLW	0377 = OCTAL
	MOVWF	TRISA					;DEFINE PORTA COMO ENTRADAS; 1=INPUT    0 =OUTPUT
	MOVLW	B'00000000'  		
	MOVWF	TRISB					;DEFINE PORTB COMO SA�DAS; 1=INPUT    0 =OUTPUT
;..............................................................................
	MOVLW	B'10000100'		
	MOVWF	OPTION_REG		;DEFINE OP��ES DE OPERA��O PRESCALER 1:2 NO TMR0;BIT 7 EM (UM) PULL-UPS DES-HABILITADOS PARA OS PINOS DE ENTRADA DO PORTB ;AS DEMAIS CONFG. S�O IRRELEVANTES
;..............................................................................
	MOVLW	B'00000000'
	MOVWF	INTCON			;DEFINE OP��ES DE INTERRUP��ES DESLIGADAS
;..............................................................................
	BANK0					;RETORNA PARA O BANCO 0   BCF  STATUS,RP0
;..............................................................................
	MOVLW	B'00000111' 	;0x07   .7 >> Desliga comparadores anal�gicos
							;	>> Em caso de d�vida - pesquisar datashets
	MOVWF	CMCON			;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO, 
							;se n�o for usar desligar ponde (7) em [CMCON] 

;========|=========|=========|=========|=========|=========|=========|=========|
;____   ____            .__                   .__        
;\   \ /   /____ _______|__|____ ___  __ ____ |__| ______
; \   Y   /\__  \\_  __ \  \__  \\  \/ // __ \|  |/  ___/
;  \     /  / __ \|  | \/  |/ __ \\   /\  ___/|  |\___ \ 
;   \___/  (____  /__|  |__(____  /\_/  \___  >__/____  >
;               \/              \/          \/        \/
;______________________________________________________________________________|
;INICIALIZA��O DAS VARI�VEIS
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
;IDENTIFICA��O  DA VES�O DO SEU PROJETO.
		__IDLOCS 0X6363 ;  
;______________________________________________________________________________|
;ROTINA PRINCIPAL
	BSF	LED3 		;LED ligado em pull down
	BSF	LED4 		;LED ligado em pull down

MAIN
	BTFSS BOT ;Espera apertar bot�o para ascender LED0
	B		$-1
	BSF	LED0		;acende
	BCF	LED7		;apaga
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1
;-------------------------------------

	BTFSS BOT ;Espera apertar bot�o para ascender LED1
	B		$-1
	BSF	LED1		;acende
	BCF	LED0		;apaga
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1
;-------------------------------------

	BTFSS BOT ;Espera apertar bot�o para ascender LED2
	B		$-1
	BCF	LED1		;apaga
	BSF	LED2		;liga
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1
;-------------------------------------
	BTFSS BOT ;Espera apertar bot�o para ascender LED3
	B		$-1
	BCF	LED2		;desliga
	BCF	LED3		;acende
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1

;-------------------------------------
	BTFSS BOT ;Espera apertar bot�o para ascender LED4
	B		$-1
	BSF	LED3		;off
	BCF	LED4		;on
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1

;-------------------------------------
	BTFSS BOT ;Espera apertar bot�o para ascender LED5
	B		$-1
	BSF	LED4 		;desliga
	BSF	LED5		;liga
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1

;-------------------------------------
	BTFSS BOT ;Espera apertar bot�o para ascender LED6
	B		$-1
	BCF	LED5		;desliga
	BSF	LED6		;liga
	
	BTFSC BOT  ;Verifica se bot�o continua pressionado
	B		$-1
;-------------------------------------
	BTFSS BOT ;Espera apertar bot�o para ascender LED7
	B		$-1
	BSF	LED7		;acende
	BCF	LED6		;apaga
	
	BTFSC BOT ;Verifica se bot�o continua pressionado
	B		$-1
;-------------------------------------
  	GOTO MAIN
    
;______________________________________________________________________________|
;FIM DO PROGRAMA
	END  ;OBRIGAT�RIO