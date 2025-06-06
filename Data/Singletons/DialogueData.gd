extends Node

# dialogue_data.gd
enum DialogueType { LORE, MISSION, TUTORIAL, ENDING }

var conversation_data := {
	"Threads": {
		"Alex": {
			"start": {
				"speaker": "Alex",
				"text": "hey can u help me download some music. i want let me love u by mario, no one by alicia keys and irreplaceable by beyonce",
				"replies": [
					{
						"text": "fine. $5 for those 3 songs.",
						"next_id": "alex_batch_1_accept",
						"type": DialogueType.MISSION
					},
					{
						"text": "sorry i'm busy",
						"next_id": "alex_decline",
						"type": DialogueType.LORE,
					}
				]
			},
			"alex_batch_1_accept": {
				"speaker": "Alex",
				"text": "thanks",
				"replies": []
			},
			"alex_decline": {
				"speaker": "Alex",
				"text": "ok whatever",
				"replies" : []
			}
		},
		"Mom": {
			"start": {
				"speaker": "Mom",
				"text": "Can you help me sell something on eBay?",
				"replies": [
					{
						"text": "I guess so. Just send me the details.",
						"next_id": "mom_ebay_accept",
						"type": DialogueType.MISSION,
					},
					{
						"text": "No, sorry. I have too much homework this week.",
						"next_id": "mom_decline",
						"type": DialogueType.LORE,
					}
				]
			},
			"mom_ebay_accept": {
				"speaker": "Mom",
				"text": "It's a vintage phone. Take pictures and post it.",
				"replies": [
					{
						"text": "Sure. I'll start right now.",
						"next_id": "mom_payment",
						"type": DialogueType.MISSION,
					}
				]
			},
			"mom_decline": {
				"speaker": "Mom",
				"text": "I was going to give you $30 for this, but how about $50?",
				"replies": [
					{
						"text": "Yeah, I can do that.",
						"next_id": "mom_payment",
						"type": DialogueType.MISSION,
					}
				]
			}
		}
	}
}
