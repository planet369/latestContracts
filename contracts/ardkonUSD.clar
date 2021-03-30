(define-fungible-token ardkonUSD)

;; the human readable name of the token
(define-read-only (get-name) 
  (ok "ardkon USD"))
;; the ticker symbol, or empty if none PASS
(define-read-only (get-symbol) 
  (ok u"ARDUSD"))

;; 10000000 the number of decimals used, e.g. 6 would mean 1_000_000 represents 1 token
(define-read-only (get-decimals) (ok u6))

;; the balance of the passed principal
(define-read-only (get-balance-of (sender principal)) 
  (ok (ft-get-balance ardkonUSD sender)))
 
;; the current total supply (which does not need to be a constant)

(define-read-only (get-total-supply) 
  (ok (ft-get-supply ardkonUSD)))

;; an optional URI that represents metadata of this token
(define-read-only (get-token-uri) (ok none))

(define-public (transfer (amount uint) (sender principal) (recipient principal)) 
  (begin 
    (asserts! (is-eq tx-sender sender) (err u401))
    (ft-transfer? ardkonUSD amount sender recipient)
  ))

(define-public (donate-to-action (amount uint) (sender principal) (contract principal)) 
  (begin 
    (asserts! (is-eq tx-sender sender) (err u401))
    (ft-transfer? ardkonUSD amount sender contract)
  ))

(define-constant private-key u"PrivateKey")
(define-map private-keys {application: (string-utf8 256)} {key: (string-utf8 256)})

(define-public (set-keys (application (string-utf8 256)) (key (string-utf8 256) ) )
  
  (begin 
  (asserts! (is-eq tx-sender (as-contract tx-sender)) (err u401))
  (map-insert private-keys  {application: application} {key: key})
  (ok u"s")
   )
)
;;Having the Private key change on every transaction and knowing exactly the function and implementing the funtion this will help us identify a better way to secure the buying. 
;;ardkon-123shty

;; How could we make the buyer easier where users upon purchare they can buy
 (map-insert private-keys  {application: u"ardkon"} {key: u"ardkon-123shty"})
(define-public (buy-ardusd (amount uint) (buyer principal) (privateKey (string-utf8 256)) (application (string-utf8 256)) ) 
  (begin 
  (let (( secret-key (map-get? private-keys {application: u"ardkon"}))) 
    
    (ok secret-key))
    ) 
  
)

(define-read-only (get-private) 
(let (( secret-key (map-get? private-keys {application: u"ardkon"}))) 
    
    (ok secret-key))
) 
