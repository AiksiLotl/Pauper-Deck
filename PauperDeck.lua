--- STEAMODDED HEADER
--- MOD_NAME: PauperDeck
--- MOD_ID: pauperdeck
--- MOD_AUTHOR: [Aiksi]
--- MOD_DESCRIPTION: It's a deck!
--- VERSION: 1.0

----------------------------------------------
------------MOD CODE -------------------------


SMODS.Back {
    key = "Pauper deck",
    config = {no_interest = true, extra_hand_bonus = 0, pauper_deck = true},
    pos = { x = 5, y = 2 },
    loc_txt = {
        name = "Pauper deck",
        text = {
            "Only {C:attention}Jokers{} can earn you {C:money}${}",
			"Start with",
			"an {C:purple}Eternal{} {C:dark_edition}Negative{} {C:attention,T:j_gift}Gift Card{p:1}",
			"Open a {C:attention,T:p_buffoon_jumbo_1}Jumbo Pack{}",
			"after defeating a {C:attention}Blind{}"
			
        }
    },
	apply = function()
		G.GAME.joker_rate = 0
		G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
		G.GAME.modifiers.no_blind_reward.Small = true
		G.GAME.modifiers.no_blind_reward.Big = true
		G.GAME.modifiers.no_blind_reward.Boss = true
		G.GAME.banned_keys['c_judgement'] = true
		G.GAME.banned_keys['c_hermit'] = true
		G.GAME.banned_keys['c_temperance'] = true
		G.GAME.banned_keys['c_devil'] = true
--		G.GAME.banned_keys['c_wraith'] = true
--		G.GAME.banned_keys['c_soul'] = true
		G.GAME.banned_keys['c_immolate'] = true
		G.GAME.banned_keys['c_talisman'] = true
		G.GAME.banned_keys['p_buffoon_normal_1'] = true
		G.GAME.banned_keys['p_buffoon_normal_2'] = true
		G.GAME.banned_keys['p_buffoon_jumbo_1'] = true
		G.GAME.banned_keys['p_buffoon_mega_1'] = true
		G.GAME.banned_keys['tag_rare'] = true
		G.GAME.banned_keys['tag_uncommon'] = true
		G.GAME.banned_keys['tag_holo'] = true
		G.GAME.banned_keys['tag_polychrome'] = true
		G.GAME.banned_keys['tag_negative'] = true
		G.GAME.banned_keys['tag_foil'] = true
		G.GAME.banned_keys['tag_buffoon'] = true
		G.GAME.banned_keys['tag_top_up'] = true
		G.GAME.banned_keys['j_swashbuckler'] = true
		G.E_MANAGER:add_event(Event({
			func = function()
				add_joker('j_gift', 'negative', true, true)
			return true
			end
		}))
	end,
	trigger_effect = function(self, args)
		if args.context == 'eval' and G.GAME.last_blind then
--			G.E_MANAGER:add_event(Event({
--				func = function()
--					add_tag(Tag('tag_buffoon'))
--					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
--					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
--					return true
--				end
--			}))
			local key = "p_buffoon_jumbo_1"
			local card = Card(
				G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
				G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
				G.CARD_W * 1.27,
				G.CARD_H * 1.27,
				G.P_CARDS.empty,
				G.P_CENTERS[key],
				{ bypass_discovery_center = true, bypass_discovery_ui = true }
			)
			card.cost = 0
			G.FUNCS.use_card({ config = { ref_table = card } } )
			card:start_materialize()

			for k, v in ipairs(G.consumeables.cards) do
				if v.set_cost then 
					v.ability.extra_value = (v.ability.extra_value or 0) - 1
					v:set_cost()
				end
			end
			return true
		end
    end
}
--local Backapply_to_runRef = Back.apply_to_run
--function Back.apply_to_run(arg)
--	Backapply_to_runRef(arg)
--	if arg.effect.config.pauper_deck then
--		G.E_MANAGER:add_event(Event({
--			func = function()
--				add_joker('j_gift', 'negative', true, true)
--			return true
--			end
--		}))
--	end
--end

----------------------------------------------
------------MOD CODE END----------------------