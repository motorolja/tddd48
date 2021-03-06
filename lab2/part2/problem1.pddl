(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                 ;defining all crate content types
                food - content
                medicine - content
                carrier1 - carrier
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
                (= (total-cost) 0)
                (next num0 num1)
                (next num1 num2)
                (next num2 num3)
                (next num3 num4)
                (free uav1)
                (has med_crate1 medicine)
                (at med_crate1 depot)
                (at uav1 depot)
                (at carrier1 depot)
                (has carrier1 num0)
                (at p1 loc1)

                (= (fly-cost depot loc1) 25)
                (= (fly-cost loc1 depot) 25)
                (= (fly-cost loc1 loc1) 0)
                (= (fly-cost depot depot) 0)
        )

        (:goal (and
               (has p1 medicine)
        )

    )
    (:metric minimize (total-cost))
)
