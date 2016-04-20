(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1 loc2 
                ;; crates
                med_crate1 
                ;; persons
                p1 
                ;; helicopters
                hel1
        )

        (:init
                (at depot loc1)
                (at med_crate1 loc1)
                (at hel1 loc1)

                
                (at p1 loc2)
                (has p1 food)
                 
        )

        (:goal (and
               (has medicine p1)
               (has food p1)
        )

	)
)
