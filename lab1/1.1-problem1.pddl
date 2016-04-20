(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1
                ;; crates
                med_crate1 
                ;; persons
                p1 
                ;; helicopters
                hel1
        )

        (:init
                (crate med_crate1)
                (location loc1)
                (person p1)
                (helicopter hel1)
		(free hel1)

                (at med_crate1 depot)
                (at hel1 depot)


		(has med_crate1 medicine)
                (at p1 loc1)
                (has p1 food)
                 
        )

        (:goal (and
;               (has medicine p1)
;               (has food p1)
               (at hel1 loc1)
        )

	)
)
