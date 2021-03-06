(define (problem emergency_prob2)
        (:domain WORLD)
        (:objects
                 ;defining all crate content types
                food - content
                medicine - content
                ;; locations

                loc1 loc2 loc3 loc4 - location
                ;; crates
                med_crate1 med_crate2 food_crate1 - crate 
                ;; persons
                p1 p2 - person
                ;; uavs
                uav1 - uav
        )

        (:init
                (free uav1)

                (at med_crate1 depot)
                (at med_crate2 depot)
                (at food_crate1 depot)
                (at uav1 depot)

                (has med_crate1 medicine)
                (has med_crate2 medicine)
                (has food_crate1 food)
                
                (at p1 loc4)
                (at p2 loc3)
                 
        )

        (:goal (and
               (has p1 medicine)
               (has p2 medicine)
               (has p2 food)
        )
    )
)
