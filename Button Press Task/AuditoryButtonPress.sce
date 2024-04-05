#%% HEADER ---------------------------

# Description:
# Task involves a blank screen black screen, and upon tapping the screen, 
# the user will hear a feedback tone
# 
# Abin Jacob 
# 04/04/2024


# header parameters 
active_buttons = 1;

#%% SDL ------------------------------
begin;

# loading the sound file
sound {wavefile {filename = "pure_tone.wav";};}feedback_tone;

# trial declarations:
# trial for button press
trial{
	trial_duration = forever;	
	trial_type = first_response;
	stimulus_event{
		picture {
			box{width = 200; height = 200; color= 0,0,0;} box_on;
			x = 0; y = 0;
		} pic_begin;
		target_button = 1;
		code = "button_press";
	} stim_tapscreen;
} trial_tapscreen;

# trial for feedback
trial{
	stimulus_event{
		sound feedback_tone;
		#code = "feedback";
		time = 0;
	} stim_present;
} trial_feedback;

# insructions trial
trial{
	trial_duration = 1000;	
	# ignore unintended response
	all_responses = false;
	stimulus_event{
		picture {
			text{caption = ""; font_size = 48; max_text_width = 1500;} text_instruction;
			x = 0; y = 0;
		} pic_intructions;
	} stim_instruction;
} instructions;




#%% PCL ------------------------------
begin_pcl;

# PARAMETERS
# total number of trials 
int ntrials = 50;

# sub routine for running the tapscreen and feedback loop
sub main_run 
begin
	# loop over trials 
	loop int itrl=1 until itrl>ntrials
	begin
		# running tapscreen trial
		trial_tapscreen.present();
		# running feedback trial
		trial_feedback.present();	
		# iterating itrl
		itrl = itrl + 1;
	end;
end;



# main run --

# welcome screen 
text_instruction.set_caption(" Welcome to the Button Press Task", true);
instructions.set_duration(2000);
instructions.present();

# running the tapscreen and feedback loop
main_run()



