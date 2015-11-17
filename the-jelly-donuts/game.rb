require 'midilib/sequence'
require 'midilib/consts'
include MIDI

class Game
  def initialize(number)
    @number = number
    puts number

    @seq = Sequence.new()

    # Create a first track for the sequence. This holds tempo events and stuff
    # like that.
    @track = Track.new(@seq)
    @seq.tracks << @track
    @track.events << Tempo.new(Tempo.bpm_to_mpq(120))
    @track.events << MetaEvent.new(META_SEQ_NAME, 'Sequence Name')

    # Give the @track a name and an instrument name (optional).
    @track.name = 'My New Track'
    @track.instrument = GM_PATCH_NAMES[0]

    # Add a volume controller event (optional).
    @track.events << Controller.new(0, CC_VOLUME, 127)

    # Add events to the @track: a major scale. Arguments for note on and note off
    # constructors are channel, note, velocity, and delta_time. Channel numbers
    # start at zero. We use the new Sequence#note_to_delta method to get the
    # delta time length of a single quarter note.
    @track.events << ProgramChange.new(0, 1, 0)

    @quarter_note_length = @seq.note_to_delta('quarter')
  end

  def find_next
    if @number == 1
      output_file
      return 1
    end

    mod = @number % 3
    if mod == 0
      puts "#{@number} / 3 = #{@number / 3}"
      @number /= 3
    elsif mod == 2
      puts "#{@number} + 1 = #{@number + 1}"
      @number += 1
    else
      puts "#{@number} - 1 = #{@number - 1}"
      @number -= 1
    end

    @track.events << NoteOn.new(0, @number, 127, 0)
    @track.events << NoteOff.new(0, @number, 127, @quarter_note_length)

    find_next
  end

  def output_file
    File.open('jelly_donut.mid', 'wb') { |file| @seq.write(file) }
  end
end
