(define-constant actionAddress (as-contract tx-sender))

;; note the contract is always deployed by ardkon application: Why? because to make sure the donations are done through the application only 


 (define-map fund-indices {action_id: (string-utf8 256)} {index: uint}) ;; this will enable us to get length of each of the following fund allocations

(define-constant owner tx-sender)

(define-map fund-allocation { action_id: (string-utf8 256),  fund_id: (string-utf8 256)} { 
                                
                                fund_name: (string-utf8 256), 
                                fund_owner: (string-utf8 256), 
                                fund_reciever_principal: principal, 
                                fund_paid: bool,  
                                USD: uint, 
                                STX: uint})

(define-map fund_reciepts  { action_id: (string-utf8 256),  fund_id: (string-utf8 256)} { 
                                
                                fund_name: (string-utf8 256), 
                                reciept_id: (string-utf8 256), 
                                fund_reciever_principal: principal, 
                                reciept_approved: bool,  
                                USD: uint, 
                                STX: uint})

(define-map total_fund_usd  { action_id: (string-utf8 256)} { usd: uint})
(define-map total_fund_stx  { action_id: (string-utf8 256)} { stx: uint})

(define-constant account-contractor 'ST1XK1467FKTFQ6K4XHWFQR4XFEK3X7PCR5J464SR) ;; change later so that it will be the same as the application

(define-data-var fund_ids (list 750 (string-utf8 256)) (list))

(define-map action-indices {action_id: (string-utf8 256)} {index: uint}) ;; this will enable us to get length of each of the following actions 

(define-map fund-registry { action_id: (string-utf8 256),  index: uint } { 
                                                                            donor-name: (string-utf8 256), 
                                                                            donation-type: (string-utf8 256),
                                                                            donor-country: (string-utf8 256), 
                                                                            donor-email: (string-utf8 256),  
                                                                            donation-currency: (string-utf8 256),
                                                                            amount: uint})


(define-data-var index uint u0)
(define-data-var is_valid uint u1)
(define-data-var validator uint u1)


(define-public (fund-stx-action (amount uint) (action_id (string-utf8 256)) (donation-type (string-utf8 256)) (donor-name (string-utf8 256)) (donor-country (string-utf8 256)) (donor-email (string-utf8 256))) 

    (let (
           (action-index (map-get? action-indices {action_id: action_id}))
          (a-index (get index action-index))
          (next-index (+ (default-to u0 a-index) u1))
          (action-amount (map-get? total_fund_stx { action_id: action_id}))
          (total-stx-fund (default-to u0 (get stx action-amount))))
        
        
        (begin 
            (map-set action-indices {action_id: action_id} {index: next-index})
            (map-set fund-registry { action_id: action_id,  index: next-index } { 
                                    donor-name: donor-name,
                                    donation-type: donation-type,
                                    donor-country: donor-country, 
                                    donor-email: donor-email,  
                                    donation-currency: u"stx",
                                    amount: amount})
          (map-set total_fund_stx { action_id: action_id} {stx: (+  total-stx-fund  amount)})
            (unwrap!         (stx-transfer? amount tx-sender actionAddress) (err u32))
            
            
            
            
            )
            (ok "donation done")
            ))
           

(define-public (fund-action-usd  ( action_id (string-utf8 256)) (donor-name (string-utf8 256)) (donor-country (string-utf8 256)) (donor-email (string-utf8 256)) (donation-type (string-utf8 256)) (amount uint))

 (let (
     
     (action-index (map-get? action-indices {action_id: action_id}))
     (a-index (get index action-index))
     (next-index (+ (default-to u0 a-index) u1))
     (action-amount (map-get? total_fund_usd { action_id: action_id}))
     (total-usd-fund (default-to u0 (get usd action-amount)))
     ) 
     (begin 
       
        (is-eq tx-sender account-contractor) ;; note when adding assertx error 
        (map-set action-indices {action_id: action_id} {index: next-index})
        (map-set fund-registry { action_id: action_id,  index: next-index } { 
                                                                            donor-name: donor-name, 
                                                                            donor-country: donor-country, 
                                                                            donor-email: donor-email,  
                                                                            donation-currency: u"USD",
                                                                            donation-type: donation-type,
                                                                            amount: amount})
       (map-set total_fund_usd { action_id: action_id} {usd: (+  total-usd-fund  amount) })
        (unwrap! (contract-call? 'ST1XK1467FKTFQ6K4XHWFQR4XFEK3X7PCR5J464SR.ard-usd-01 donate-to-action-guest amount actionAddress) (err u12))

       )
     (ok "donation added") )
        
)
 

(define-public (add-fund-allocation (fund_name (string-utf8 256)) (action_id (string-utf8 256)) (fund_owner (string-utf8 256)) (fund_id (string-utf8 256)) (fund_reciever_principal principal) (ardUSD uint) (ardSTX uint)) 
;; let the action-id owner add fund allocation to his action 
 
    
    (begin 
        
        (asserts! (is-eq tx-sender  owner) (err u21))
        (map-set fund-allocation { action_id: action_id,  fund_id: fund_id} { 
                                fund_name: fund_name, 
                                fund_owner: fund_owner, 
                                fund_reciever_principal: fund_reciever_principal, 
                                fund_paid: false, 
                                STX: ardSTX,
                                USD: ardUSD})
       
          ;; note when appending list error
     (ok "add fund allocation")
     )
)


(define-public (add-fund-reciepts (fund_name (string-utf8 256)) (action_id (string-utf8 256)) (reciept_id (string-utf8 256)) (fund_id (string-utf8 256))  (ardUSD uint) (ardSTX uint)) 
;; let the action-id owner add fund allocation to his action 
 
 (let (

   (fund_info (unwrap! (map-get? fund-allocation { action_id: action_id,  fund_id: fund_id}) (err 21) ))
    (reciever (get fund_reciever_principal fund_info))
     
        
 ) 
    
    
      (begin 
      
      

      
        (asserts! (is-eq reciever tx-sender ) (err 211))
        
        (map-set fund_reciepts { action_id: action_id,  fund_id: fund_id} { 
                               fund_name: fund_name, 
                                reciept_id: reciept_id, 
                                fund_reciever_principal: tx-sender, 
                                reciept_approved: false,  
                                USD: ardUSD, 
                                STX: ardSTX})
        (ok "add reciepts ")
      ) 
      
     )
     
)




(define-public (collect-funds (fund_id (string-utf8 256)) (action_id (string-utf8 256))) 

  (let (
    
    
     (fund_info (unwrap! (map-get? fund-allocation { action_id: action_id,  fund_id: fund_id}) (err 21) ))
      (reciever (get fund_reciever_principal fund_info))
      (USD   (get USD fund_info))
      (STX  (get STX fund_info))
      (usd_tuple (default-to {usd: u0}  (map-get? total_fund_usd { action_id: action_id}) ))
      (total_usd (get usd usd_tuple))
      (stx_tuple (default-to {stx: u0} (map-get? total_fund_stx { action_id: action_id}) ))
      (total_stx (get stx stx_tuple))
    ) 
       (begin 
        
        (asserts! (>= total_stx  STX ) (err 222))
        (asserts! (>= total_usd  USD ) (err 333))
        (if (> total_stx u0)
             
            (unwrap! (stx-transfer? STX actionAddress tx-sender) (err 211))
            false


        )
        

    

          (ok "Collection Done")
       )
         
       

    )

)
