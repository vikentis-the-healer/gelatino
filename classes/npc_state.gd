class_name NPCState extends State

const IDLE = "Idle"
const PURSUEING = "Pursueing"
const ATTACKING = "Attacking"
const EXHAUSTED = "Exhausted"
const FLEEING = "Fleeing"
const DYING = "Dying"

var npc: Character


func _ready() -> void:
	await owner.ready
	npc = owner as Character
	assert(npc != null, "The NPC state type must be used \
	only in an NPC scene. It needs the owner to be a \
	Character node.")
