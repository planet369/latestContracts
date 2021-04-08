(define-constant actionAddress (as-contract tx-sender) )
;; Define the action address which is the same as the smart contract 

;;This contract will explain a contract that will act as one action where each action exposed will create this action for it. 

 
 (define-map fund-indices {action_id: (string-utf8 256)} {index: uint}) ;; this will enable us to get length of each of the following actions 


(define-map fund-allocation { action_id: (string-utf8 256),  index: uint} { 
                                fund_name: (string-utf8 256), 
                                fund_owner: (string-utf8 256), 
                                fund_reciever_principal: principal, 
                                fund_paid: bool,  
                                ardkonUSD: uint})

(define-map fund_reciepts  { action_id: (string-utf8 256), fund_name: (string-utf8 256), reciept_id: (string-utf8 256), reciept_owner: principal, recieved: bool  } {ardkonUSD: uint, ardkonStacks: uint})

(define-map total_fund_usd  { action_id: (string-utf8 256)} { ardkon-usd: uint})
(define-map total_fund_stx  { action_id: (string-utf8 256)} { stx: uint})
(define-map total_fund_collected  { action_id: (string-utf8 256)} { ardkonUSD: uint, ardkonStacks: uint})

(define-constant account-contractor 'ST1XK1467FKTFQ6K4XHWFQR4XFEK3X7PCR5J464SR)

(define-map action-indices {action_id: (string-utf8 256)} {index: uint}) ;; this will enable us to get length of each of the following actions 


(define-map fund-registry { action_id: (string-utf8 256),  index: uint } { 
                                                                            donor-name: (string-utf8 256), 
                                                                            donor-country: (string-utf8 256), 
                                                                            donor-email: (string-utf8 256),  
                                                                            donation-currency: (string-utf8 256),
                                                                            amount: uint})


(define-data-var index uint u0)

(define-read-only (get-fund (action_id (string-utf8 256)) (index-f uint))

    (map-get? fund-registry {action_id: action_id, index: index-f})

)

(define-read-only (get-action-index (action_id (string-utf8 256))) 
 (let (
        
        (a-index (map-get? action-indices { action_id: action_id}))
        (action_index (get index a-index))
        
        )
           (ok action_index) 
        )

)



(define-public (fund-action-usd  ( action_id (string-utf8 256)) (donor-name (string-utf8 256)) (donor-country (string-utf8 256)) (donor-email (string-utf8 256)) (amount uint))

 (let (
     
     (action-index (map-get? action-indices {action_id: action_id}))
     (a-index (get index action-index))
     (next-index (+ (default-to u0 a-index) u1))
     (action-amount (map-get? total_fund_usd { action_id: action_id}))
     (total-usd-fund (default-to u0 (get ardkon-usd action-amount)))
     ) 
     (begin 
        (is-eq tx-sender account-contractor)
        (map-set action-indices {action_id: action_id} {index: next-index})
        (map-set fund-registry { action_id: action_id,  index: next-index } { 
                                                                            donor-name: donor-name, 
                                                                            donor-country: donor-country, 
                                                                            donor-email: donor-email,  
                                                                            donation-currency: u"ardkonUSD",
                                                                            amount: amount})
       (map-set total_fund_usd { action_id: action_id} {ardkon-usd: (+  total-usd-fund  amount) })
       (unwrap! (contract-call? 'ST1XK1467FKTFQ6K4XHWFQR4XFEK3X7PCR5J464SR.ard-usd-01 donate-to-action-guest amount tx-sender) (err u12))
       )
     (ok "donation added") )
        
)
 


  


  
    

    



(define-public (add-fund-allocation (fund_name (string-utf8 256)) (action_id (string-utf8 256)) (fund_owner (string-utf8 256)) (fund_reciever_principal principal) (amountUSD uint)) 
;; let the action-id owner add fund allocation to his action 
(let (
    (fund-index (map-get? fund-indices {action_id: action_id}) )
    (f-index (get index fund-index))
    (next-index (+ (default-to u0 f-index) u1))
    ) 
    
    (begin 
        (is-eq tx-sender  actionAddress)
        (map-set fund-allocation { action_id: action_id,  index: next-index} { 
                                fund_name: fund_name, 
                                fund_owner: fund_owner, 
                                fund_reciever_principal: fund_reciever_principal, 
                                fund_paid: false,  
                                ardkonUSD: amountUSD})
        (map-set fund-indices {action_id: action_id} {index: next-index})
          
     (ok "value")
     ))
)





(define-public (add-reciepts) 
;; let fund owner to add his receipt
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (accept-reciepts) 
;; let the commity of donors and checkers to accept the reciepts presented
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (submit-proof-of-fund) 
;; submitting a proof of fund where it can be a link to an image
(begin (print "action_id")
    (ok "value")
  
    )
)
(define-read-only (get-proof-of-fund (fund_id (string-utf8 256)) (proof_id (string-utf8 256)))
    (ok "value")
)
(define-public (voting-on-fund-proof) 
;; submitting a proof of fund where it can be a link to an image
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (collect-funds) 
;; let fund owner collect his funds upon aproval of the system with a valid reciept id
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (return-funds) 
;; this happens if the actions fails to be submitted
(begin (print "action_id")
    (ok "value")
  
    )
)


  
(define-public (fund-stx-action (amount uint) (action_id (string-utf8 256)) (donor-name (string-utf8 256)) (donor-country (string-utf8 256)) (donor-email (string-utf8 256))) 

    (let (
        
        (action-index (map-get? action-indices {action_id: action_id}))
        (a-index (get index action-index))
        (next-index (+ (default-to u0 a-index) u1))
        (action-amount (map-get? total_fund_stx { action_id: action_id}))
        (total-stx-fund (default-to u0 (get stx action-amount)))

        )
         (begin 
         (map-set action-indices {action_id: action_id} {index: next-index})
         (map-set fund-registry { action_id: action_id,  index: next-index } { 
                                                                            donor-name: donor-name, 
                                                                            donor-country: donor-country, 
                                                                            donor-email: donor-email,  
                                                                            donation-currency: u"stx",
                                                                            amount: amount})
            (map-set total_fund_stx { action_id: action_id} {stx: (+  total-stx-fund  amount) })
            (unwrap!          (stx-transfer? amount tx-sender actionAddress) (err u32))
         )
         (ok "donation done")
         )
)