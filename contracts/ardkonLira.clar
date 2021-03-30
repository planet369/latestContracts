(define-fungible-token ardkonLira)

;; the human readable name of the token
(define-read-only (get-name) 
  (ok "ardkon Lira"))
;; the ticker symbol, or empty if none PASS
(define-read-only (get-symbol) 
  (ok "ARDL"))

;; 10000000 the number of decimals used, e.g. 6 would mean 1_000_000 represents 1 token
(define-read-only (get-decimals) (ok u6))

;; the balance of the passed principal
(define-read-only (get-balance-of (sender principal)) 
  (ok (ft-get-balance ardkonLira sender)))
 
;; the current total supply (which does not need to be a constant)

(define-read-only (get-total-supply) 
  (ok (ft-get-supply ardkonLira)))

;; an optional URI that represents metadata of this token
(define-read-only (get-token-uri) (ok none))

(define-public (transfer (amount uint) (sender principal) (recipient principal)) 
  (begin 
    (asserts! (is-eq tx-sender sender) (err u401))
    (ft-transfer? ardkonLira amount sender recipient)
  ))

(define-public (donate-to-action (amount uint) (sender principal) (contract principal)) 
  (begin 
    (asserts! (is-eq tx-sender sender) (err u401))
    (ft-transfer? ardkonLira amount sender contract)
  ))

(define-constant private-key u"PrivateKey")



;;Having the Private key change on every transaction and knowing exactly the function and implementing the funtion this will help us identify a better way to secure the buying. 


;; How could we make the buyer easier where users upon purchare they can buy
(define-public (buy (amount uint) (buyer principal) (privateKey (string-utf8 256))) 
    (begin 
        (asserts! (is-eq tx-sender buyer) ((err u401))
        (asserts! (is-eq privateKey private-key) ((err u402))
        ((ft-mint? ardkonLira amount buyer))
    )
)

