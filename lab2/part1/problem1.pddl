(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                 ;defining all crate content types
                food - content
                medicine - content

                ;; locations
                loc1 - location
                ;; crates
                med_crate1 - crate
                ;; persons
                p1 - person
                ;; uavs
                uav1 - uav
        )

        (:init
                (next num0 num1)
                (next num1 num2)
                (next num2 num3)
                (next num3 num4)
                (free uav1)
                (has med_crate1 medicine)
                (at med_crate1 depot)
                (at uav1 depot)

                
                (at p1 loc1)
        )

        (:goal (and
               (has p1 medicine)
        )

    )
)
