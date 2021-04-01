(define-fungible-token ardkonUSD)



;; Errors:

(define-constant ERR-not-application u401)


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




(define-constant account-contractor 'SP1BBF4MY50BJW4YT1NVQPZMG20S52S2C71TRK5B6)
;; How could we make the buyer easier where users upon purchare they can buy

;; instead of the process of buying usd it is better to just transsfer the amount directly to the account holder 
;; but as well this will give us the oppurtunity to make double case scenarios where a user can transfer his funds to ardkon usd and then he can choose to donate to several actions and this will be most basically used in the process of having a wallet 


(define-public (donate-to-action-guest (amount uint)  (contract principal)) 
  (begin 
    (asserts! (is-eq tx-sender account-contractor) (err u401))
    (ft-mint? ardkonUSD amount contract)
  ))

(define-public (buy-ardUSD (amount uint) (buyer principal) ) 
 
  (begin 
  
  (asserts! (is-eq tx-sender account-contractor) (err u401))
  (ft-mint? ardkonUSD amount buyer)
  )
  
)

;; First Method is that the user purchase USD and then he can donate any amount he requests to other contracts(this is the most )