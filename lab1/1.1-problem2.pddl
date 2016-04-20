(define (problem emergency_prob2)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1 loc2 loc3 loc4
                ;; crates
                med_crate1 med_crate2 food_crate1 
                ;; persons
                p1 p2
                ;; helicopters
                hel1
        )

        (:init
                (at depot loc1)
                (at med_crate1 loc1)
                (at med_crate2 loc1)
                (at food_crate1 loc1)
                (at hel1 loc1)

                
                (at p1 loc4)
                (at p2 loc3)
                (has p1 food)
                 
        )

        (:goal (and
               (has medicine p1)
               (has medicine p2)
               (has food p1)
               (has food p2)
        )

)