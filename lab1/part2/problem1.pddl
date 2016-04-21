(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1 - location
                ;; crates
                med_crate1 - crate
                ;; persons
                p1 - person
                ;; helicopters
                hel1 - helicopter
        )

        (:init
                (free hel1)
                (has med_crate1 medicine)
                (at med_crate1 depot)
                (at hel1 depot)

                
                (at p1 loc1)
        )

        (:goal (and
               (has p1 medicine)
        )

    )
)