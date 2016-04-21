(define (domain WORLD)
    (:requirements :strips :typing);; require STRIPS
    (:types crate content location person helicopter)
    (:predicates 
        ;expressions for checks
        (free ?h)
        (at ?o ?l)
        (has ?o ?t)
    )
    (:constants
        food medicine - content
        depot - location
    )
    (:action give
        :parameters (?helicopter - helicopter
                     ?crate - crate 
                     ?content - content 
                     ?person - person 
                     ?location - location)
        :precondition (
                    and
                    ;location confirmation
                    (at ?helicopter ?location)
                    (at ?person ?location)

                    ;possession confirmation
                    (has ?helicopter ?crate)
                    (has ?crate ?content)
                    )
        :effect (and
                    ;dropping crate
                    (not (has ?helicopter ?crate))
                    (free ?helicopter)
                    (at ?crate ?location)

                    ;giving content to person
                    (not (has ?crate ?content))
                    (has ?person ?content)
            )
    )
    (:action move
        :parameters (?helicopter - helicopter
                     ?from - location
                     ?to - location)
        :precondition (and
                        ;location confirmation
                        (at ?helicopter ?from)
                     )
        :effect (and
                        ;moving helicopter
                        (not (at ?helicopter ?from))
                        (at ?helicopter ?to)
                     )
    )
    (:action pick
        :parameters (?helicopter - helicopter
                     ?crate - crate
                     ?location - location)
        :precondition (and
                        ;location confirmation
                        (at ?helicopter ?location)
                        (at ?crate ?location)
                        (free ?helicopter)
                       )
        :effect (and
                        ;taking object
                        (not (at ?crate ?location))
                        (has ?helicopter ?crate)

                        ;setting helicopter as not free
                        (not (free ?helicopter))
                     )
    )
    (:action drop
        :parameters (?helicopter - helicopter
                     ?crate - crate
                     ?location - location)
        :precondition (and
                        ;location confirmation
                        (at ?helicopter ?location)

                        ;possession confirmation
                        (has ?helicopter ?crate)
                     )
        :effect (and
                        ;drop object
                        (at ?crate ?location)
                        (not (has ?helicopter ?crate))

                        ;setting helicopter as free
                        (free ?helicopter)
                     )
    )
)
