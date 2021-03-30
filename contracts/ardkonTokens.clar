;; this token could be used to ensure ownership of action
(define-non-fungible-token actions_token { action_name: (string-utf8 256), action_id: (string-utf8 256)})

(nft-mint? actions_token {action_name: u"Simple", action_id: u"ceed1f10-dd8a-4703-8ddc-f94fadaaa779"} tx-sender)

;; this token could be used in the auctions
(define-non-fungible-token auctions_token {action_id: (string-utf8 256), auction_id: (string-utf8 256)})
(nft-mint? auctions_token {action_id: u"ceed1f10-dd8a-4703-8dc-f94fadaaa77d9", auction_id: u"ceed1s10-dd8a-4703-8ddc-f94fadaaa779" } tx-sender)

